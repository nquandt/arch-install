#!/usr/bin/env bash
# One-shot desktop + dev environment after minimal Arch (see arch-install.md).
# Usage: bash install.sh [--performance] [--claude-code]
set -euo pipefail
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

INSTALL_CLAUDE_CODE="${INSTALL_CLAUDE_CODE:-0}"
PROFILE_PERFORMANCE="${PROFILE_PERFORMANCE:-0}"
for arg in "$@"; do
  case "$arg" in
    --claude-code) INSTALL_CLAUDE_CODE=1 ;;
    --performance|--powerful) PROFILE_PERFORMANCE=1 ;;
    -h|--help)
      echo "Usage: bash install.sh [options]"
      echo "  (default)       low-power / iGPU: minimal compositing, zram, sysctl, earlyoom"
      echo "  --performance   stronger machine: Hyprland blur+animations, Waybar cava,"
      echo "                  translucent Ghostty; skips zram sysctl earlyoom"
      echo "  --claude-code   Anthropic Claude Code CLI"
      echo "  PROFILE_PERFORMANCE=1 bash install.sh   same as --performance"
      exit 0
      ;;
  esac
done

ok()   { echo "  [ok]     $1"; }
info() { echo "  [...]    $1"; }
warn() { echo "  [warn]   $1"; }
fail() { echo "  [fail]   $1"; exit 1; }
has()  { command -v "$1" &>/dev/null; }

need_sudo() {
  sudo -n true 2>/dev/null || { info "sudo access required"; sudo true; }
}

pacman_install() {
  local p="$1"
  pacman -Qi "$p" &>/dev/null && { ok "$p"; return 0; }
  info "pacman -S $p"
  sudo pacman -S --needed --noconfirm "$p"
  ok "$p"
}

paru_install() {
  local p="$1"
  pacman -Qi "$p" &>/dev/null && { ok "$p"; return 0; }
  info "paru -S $p"
  paru -S --noconfirm "$p"
  ok "$p"
}

ensure_paru() {
  has paru && return 0
  info "paru not found — building from AUR (base-devel + a few minutes)"
  need_sudo
  sudo pacman -S --needed --noconfirm base-devel git
  local tmp
  tmp="$(mktemp -d)"
  git clone --depth 1 https://aur.archlinux.org/paru.git "$tmp/paru"
  ( cd "$tmp/paru" && makepkg -si --noconfirm )
  rm -rf "$tmp"
  has paru || fail "paru failed — see https://wiki.archlinux.org/title/AUR_helpers"
}

link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [[ -e $dest && ! -L $dest ]]; then warn "backup $dest → .bak"; mv "$dest" "$dest.bak"; fi
  [[ -L $dest ]] && rm -f "$dest"
  ln -s "$src" "$dest"
  ok "$dest"
}

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Arch dotfiles installer  ($([[ $PROFILE_PERFORMANCE -eq 1 ]] && echo performance || echo low-power))"
echo "  $DOTFILES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

need_sudo
has git  || pacman_install git

ensure_paru

echo ""
echo "→ core packages (Hyprland, audio, term, editors)"
# pipewire-jack: pick provider once; intel GPU pkgs harmless on AMD-only
set +e
for p in \
  hyprland waybar wofi sddm dunst pamixer wob pacman-contrib \
  wl-clipboard cliphist hyprshot \
  xdg-desktop-portal-hyprland xdg-utils \
  qt5-wayland qt6-wayland polkit-kde-agent \
  ttf-jetbrains-mono-nerd noto-fonts noto-fonts-emoji \
  gnome-themes-extra gtk4 nwg-look papirus-icon-theme \
  pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber \
  tmux neovim zsh fzf starship ripgrep fd tree-sitter-cli gcc cmake make \
  swaylock slurp python eza bat mesa firefox thermald; do
  pacman_install "$p" || warn "skip: $p"
done
if [[ $PROFILE_PERFORMANCE -eq 1 ]]; then
  pacman_install cava || warn "skip: cava"
else
  for p in zram-generator earlyoom; do
    pacman_install "$p" || warn "skip: $p"
  done
fi
for p in vulkan-intel intel-media-driver luarocks tree-sitter-cli; do
  pacman_install "$p" || warn "optional: $p"
done
set -e

echo ""
echo "→ AUR"
paru_install ghostty
paru_install wl-screenrec 2>/dev/null || warn "wl-screenrec AUR optional (Super+y record)"

if pacman -Qi tmux-plugin-manager &>/dev/null; then
  ok "tmux-plugin-manager"
else
  mkdir -p "$HOME/.tmux/plugins"
  [[ -d $HOME/.tmux/plugins/tpm ]] || git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  ok "TPM → ~/.tmux/plugins/tpm"
fi

echo ""
echo "→ optional (nvim markdown preview)"
pacman_install nodejs 2>/dev/null && pacman_install npm 2>/dev/null || warn "skip nodejs/npm"

echo ""
echo "→ symlinks"
link "$DOTFILES/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
if [[ $PROFILE_PERFORMANCE -eq 1 ]]; then
  link "$DOTFILES/hypr/hyprland.local.performance" "$HOME/.config/hypr/hyprland.local.conf"
  link "$DOTFILES/waybar/config.performance" "$HOME/.config/waybar/config"
  link "$DOTFILES/ghostty/config.performance" "$HOME/.config/ghostty/config"
else
  link "$DOTFILES/hypr/hyprland.local.lowpower" "$HOME/.config/hypr/hyprland.local.conf"
  link "$DOTFILES/waybar/config" "$HOME/.config/waybar/config"
  link "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"
fi
link "$DOTFILES/hypr/cleanup_after_start.sh" "$HOME/.config/hypr/cleanup_after_start.sh"
link "$DOTFILES/hypr/record.sh" "$HOME/.config/hypr/record.sh"
link "$DOTFILES/waybar/default-modules.json" "$HOME/.config/waybar/default-modules.json"
link "$DOTFILES/waybar/style.css" "$HOME/.config/waybar/style.css"
mkdir -p "$HOME/.config/waybar/scripts"
for f in "$DOTFILES/waybar/scripts/"*; do
  [[ -f $f ]] && link "$f" "$HOME/.config/waybar/scripts/$(basename "$f")"
done
link "$DOTFILES/wofi/style.css" "$HOME/.config/wofi/style.css"
[[ -d $DOTFILES/ghostty/themes ]] && link "$DOTFILES/ghostty/themes" "$HOME/.config/ghostty/themes"
link "$DOTFILES/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
link "$DOTFILES/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"
link "$DOTFILES/nvim" "$HOME/.config/nvim"
link "$DOTFILES/scripts" "$HOME/.config/scripts"
link "$DOTFILES/starship.toml" "$HOME/.config/starship.toml"
link "$DOTFILES/shell/zshrc" "$HOME/.zshrc"
link "$DOTFILES/shell/zprofile" "$HOME/.zprofile"

echo ""
echo "→ default shell → zsh"
if [[ "$(getent passwd "$(id -un)" | cut -d: -f7)" == "/usr/bin/zsh" ]]; then
  ok "login shell already /usr/bin/zsh"
else
  sudo chsh -s /usr/bin/zsh "$(id -un)" && ok "chsh → /usr/bin/zsh (re-login to apply everywhere)" || \
    warn "chsh failed — run: sudo chsh -s /usr/bin/zsh \$USER"
fi

chmod +x "$DOTFILES/scripts/"* "$DOTFILES/hypr/"*.sh 2>/dev/null || true
chmod +x "$DOTFILES/waybar/scripts/"* 2>/dev/null || true

echo ""
if [[ $PROFILE_PERFORMANCE -eq 1 ]]; then
  echo "→ performance profile: skipping zram / sysctl low-power / earlyoom"
  sudo systemctl disable --now earlyoom 2>/dev/null || true
  sudo systemctl enable --now thermald 2>/dev/null && ok "thermald" || warn "thermald"
else
  echo "→ low-power tuning (sysctl, zram, thermald, earlyoom)"
  if [[ -f $DOTFILES/system/99-lowpower-sysctl.conf ]]; then
    sudo cp "$DOTFILES/system/99-lowpower-sysctl.conf" /etc/sysctl.d/99-lowpower-dotfiles.conf
    sudo sysctl -p /etc/sysctl.d/99-lowpower-dotfiles.conf &>/dev/null || true
    ok "sysctl low-power profile"
  fi
  if [[ ! -f /etc/systemd/zram-generator.conf ]] && [[ -f $DOTFILES/system/zram-generator.conf ]]; then
    sudo cp "$DOTFILES/system/zram-generator.conf" /etc/systemd/zram-generator.conf
    ok "zram-generator.conf (reboot for zram0)"
  fi
  sudo systemctl daemon-reload 2>/dev/null || true
  sudo systemctl enable --now thermald 2>/dev/null && ok "thermald" || warn "thermald"
  sudo systemctl enable --now earlyoom 2>/dev/null && ok "earlyoom" || warn "earlyoom"
fi
sudo systemctl daemon-reload 2>/dev/null || true

sudo systemctl enable --now NetworkManager 2>/dev/null || true
systemctl is-enabled sddm &>/dev/null || sudo systemctl enable sddm
systemctl --user enable --now pipewire pipewire-pulse wireplumber 2>/dev/null || \
  systemctl --user enable pipewire pipewire-pulse wireplumber

if [[ "$INSTALL_CLAUDE_CODE" == "1" ]]; then
  echo ""
  echo "→ Claude Code CLI (https://docs.anthropic.com/en/docs/claude-code/setup)"
  if has claude; then
    ok "claude already on PATH"
  else
    info "running Anthropic install script…"
    if curl -fsSL https://claude.ai/install.sh | bash; then
      ok "Claude Code — run: claude login  (or set ANTHROPIC_API_KEY)"
    else
      warn "Claude install failed — try: npm install -g @anthropic-ai/claude-code"
    fi
  fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Done."
echo ""
echo "  1. Log out & back in (or reboot) so zsh is your login shell everywhere"
echo "  2. sudo reboot            → SDDM → Hyprland"
echo "  3. tmux: Ctrl+s then I    (TPM) — panes use zsh"
echo "  4. Firefox: Super+B       |  Claude Code: bash install.sh --claude-code"
echo ""
echo "  Neovim ≥ 0.11 | docs/system-optimization.md"
if [[ $PROFILE_PERFORMANCE -eq 1 ]]; then
  echo "  Profile: performance — re-run without flag to restore low-power tuning."
else
  echo "  Profile: low-power — use --performance on a faster box."
  echo "  Reboot once for zram if first low-power install."
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
