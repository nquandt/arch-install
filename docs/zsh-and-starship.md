# Zsh & Starship

## Zsh (login shell)

**Configs:**

- **`shell/zshrc`** → **`~/.zshrc`** (symlink)
- **`shell/zprofile`** → **`~/.zprofile`** (symlink)

**install.sh** runs **`chsh -s /usr/bin/zsh`** so new logins use zsh. **arch-install.md** can create the user with zsh from day one.

### What’s in `shell/zshrc`

- Large shared **history** (`~/.histfile`)
- **Completion** (`compinit`)
- **`EDITOR=nvim`**
- **PATH:** `~/.local/bin`, `~/.cargo/bin`, `~/.npm-global/bin`, `~/.dotnet/tools`
- **Aliases** for **eza** / **bat** when installed, plus **`wall`** (wallpaper-set) and **`theme`** (theme-switch)
- **Starship** prompt last (so it picks up env)

### Customizing

Edit **`shell/zshrc`** in the repo (symlink means changes apply in new shells). For secrets (API keys), add lines at the bottom of **`shell/zshrc`** or use a **`.zshrc.local`** pattern:

```zsh
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
```

(You can add that line to **`shell/zshrc`** once; keep **`~/.zshrc.local`** untracked.)

## Starship

**Config:** **`starship.toml`** → **`~/.config/starship.toml`**

Catppuccin Mocha palette. Edit **`starship.toml`** to change modules (git branch, directory, etc.).

- [Starship preset / config](https://starship.rs/config/)
