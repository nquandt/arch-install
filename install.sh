#!/usr/bin/env bash

set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  nquandt dotfiles installer"
echo "  source: $DOTFILES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# ── Helpers ───────────────────────────────────────────────

ok()   { echo "  [ok]     $1"; }
info() { echo "  [...]    $1"; }
warn() { echo "  [warn]   $1"; }
fail() { echo "  [fail]   $1"; exit 1; }

has() { command -v "$1" &>/dev/null; }

pacman_install() {
  local pkg="$1"
  if pacman -Qi "$pkg" &>/dev/null; then
    ok "$pkg already installed"
  else
    info "installing $pkg..."
    sudo pacman -S --noconfirm "$pkg"
    ok "$pkg installed"
  fi
}

paru_install() {
  local pkg="$1"
  if pacman -Qi "$pkg" &>/dev/null; then
    ok "$pkg already installed"
  else
    info "installing $pkg (AUR)..."
    paru -S --noconfirm "$pkg"
    ok "$pkg installed"
  fi
}

link() {
  local src="$1"
  local dest="$2"
  local dir
  dir="$(dirname "$dest")"

  mkdir -p "$dir"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    warn "backing up $dest -> $dest.bak"
    mv "$dest" "$dest.bak"
  fi

  if [ -L "$dest" ]; then
    rm "$dest"
  fi

  ln -s "$src" "$dest"
  ok "linked $dest"
}

# ── Preflight ─────────────────────────────────────────────

echo ""
echo "→ Checking prerequisites..."

has git  || fail "git not found — install with: sudo pacman -S git"
has paru || fail "paru not found — install AUR helper first (see setup guide)"

# ── Packages ──────────────────────────────────────────────

echo ""
echo "→ Installing pacman packages..."

pacman_install hyprland
pacman_install waybar
pacman_install wofi
pacman_install sddm
pacman_install tmux
pacman_install neovim
pacman_install wl-clipboard
pacman_install xdg-desktop-portal-hyprland
pacman_install xdg-utils
pacman_install qt5-wayland
pacman_install qt6-wayland
pacman_install polkit-kde-agent
pacman_install ttf-jetbrains-mono-nerd
pacman_install noto-fonts
pacman_install noto-fonts-emoji
pacman_install gnome-themes-extra
pacman_install gtk4
pacman_install nwg-look
pacman_install papirus-icon-theme
pacman_install pipewire
pacman_install pipewire-alsa
pacman_install pipewire-pulse
pacman_install pipewire-jack
pacman_install wireplumber
pacman_install ripgrep
pacman_install fd
pacman_install tree-sitter-cli
pacman_install gcc
pacman_install luarocks

echo ""
echo "→ Installing AUR packages..."

paru_install ghostty
paru_install tmux-plugin-manager

# ── TPM ───────────────────────────────────────────────────

echo ""
echo "→ Setting up TPM..."

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  if [ -d "/usr/share/tmux-plugin-manager" ]; then
    mkdir -p "$HOME/.tmux/plugins"
    ln -s /usr/share/tmux-plugin-manager "$HOME/.tmux/plugins/tpm"
    ok "TPM linked from /usr/share/tmux-plugin-manager"
  else
    warn "tmux-plugin-manager not found in /usr/share, cloning from GitHub..."
    mkdir -p "$HOME/.tmux/plugins"
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    ok "TPM cloned from GitHub"
  fi
else
  ok "TPM already present at ~/.tmux/plugins/tpm"
fi

# ── Symlinks ──────────────────────────────────────────────

echo ""
echo "→ Linking configs..."

link "$DOTFILES/hypr/hyprland.conf"  "$HOME/.config/hypr/hyprland.conf"
link "$DOTFILES/waybar/config"       "$HOME/.config/waybar/config"
link "$DOTFILES/waybar/style.css"    "$HOME/.config/waybar/style.css"
link "$DOTFILES/wofi/style.css"      "$HOME/.config/wofi/style.css"
link "$DOTFILES/ghostty/config"      "$HOME/.config/ghostty/config"
link "$DOTFILES/tmux/tmux.conf"      "$HOME/.config/tmux/tmux.conf"
link "$DOTFILES/nvim/init.lua"       "$HOME/.config/nvim/init.lua"

# ── Services ──────────────────────────────────────────────

echo ""
echo "→ Enabling services..."

if ! systemctl is-enabled sddm &>/dev/null; then
  sudo systemctl enable sddm
  ok "sddm enabled"
else
  ok "sddm already enabled"
fi

if ! systemctl --user is-enabled pipewire &>/dev/null; then
  systemctl --user enable --now pipewire pipewire-pulse wireplumber
  ok "pipewire enabled"
else
  ok "pipewire already enabled"
fi

# ── Validation ────────────────────────────────────────────

echo ""
echo "→ Validating..."

errors=0

validate_link() {
  if [ -L "$1" ] && [ -e "$1" ]; then
    ok "$1"
  else
    warn "missing symlink: $1"
    errors=$((errors + 1))
  fi
}

validate_link "$HOME/.config/hypr/hyprland.conf"
validate_link "$HOME/.config/waybar/config"
validate_link "$HOME/.config/waybar/style.css"
validate_link "$HOME/.config/wofi/style.css"
validate_link "$HOME/.config/ghostty/config"
validate_link "$HOME/.config/tmux/tmux.conf"
validate_link "$HOME/.config/nvim/init.lua"

[ -d "$HOME/.tmux/plugins/tpm" ] && ok "~/.tmux/plugins/tpm" || { warn "TPM not found"; errors=$((errors + 1)); }

if [ $errors -gt 0 ]; then
  echo ""
  warn "$errors validation error(s) — review warnings above"
else
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  All done! Next steps:"
  echo ""
  echo "  1. Start tmux and press Ctrl+Space + I to install plugins"
  echo "  2. Open nvim — lazy.nvim will auto-install plugins"
  echo "  3. Run nwg-look to apply Adwaita-dark GTK theme"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi
