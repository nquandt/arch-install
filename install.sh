#!/usr/bin/env bash

set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  nquandt dotfiles installer"
echo "  source: $DOTFILES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Helper: create symlink, backing up any existing file
link() {
  local src="$1"
  local dest="$2"
  local dir
  dir="$(dirname "$dest")"

  mkdir -p "$dir"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "  [backup] $dest -> $dest.bak"
    mv "$dest" "$dest.bak"
  fi

  if [ -L "$dest" ]; then
    rm "$dest"
  fi

  ln -s "$src" "$dest"
  echo "  [linked] $dest"
}

echo ""
echo "→ Linking Hyprland..."
link "$DOTFILES/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"

echo ""
echo "→ Linking Waybar..."
link "$DOTFILES/waybar/config"    "$HOME/.config/waybar/config"
link "$DOTFILES/waybar/style.css" "$HOME/.config/waybar/style.css"

echo ""
echo "→ Linking wofi..."
link "$DOTFILES/wofi/style.css" "$HOME/.config/wofi/style.css"

echo ""
echo "→ Linking Ghostty..."
link "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"

echo ""
echo "→ Linking tmux..."
link "$DOTFILES/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"

echo ""
echo "→ Linking Neovim..."
link "$DOTFILES/nvim/init.lua" "$HOME/.config/nvim/init.lua"

echo ""
echo "→ Setting up TPM..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  if [ -d "/usr/share/tmux-plugin-manager" ]; then
    mkdir -p "$HOME/.tmux/plugins"
    ln -s /usr/share/tmux-plugin-manager "$HOME/.tmux/plugins/tpm"
    echo "  [linked] ~/.tmux/plugins/tpm"
  else
    echo "  [skip] tmux-plugin-manager not found — install it with: paru -S tmux-plugin-manager"
  fi
else
  echo "  [skip] TPM already present"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Done! Next steps:"
echo ""
echo "  1. Start tmux and press Ctrl+Space + I to install plugins"
echo "  2. Open nvim — lazy.nvim will auto-install plugins"
echo "  3. Run nwg-look to apply Adwaita-dark GTK theme"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
