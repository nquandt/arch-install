# Optional: Claude Code

← [Documentation index](README.md)

[Claude Code](https://docs.anthropic.com/en/docs/claude-code/setup) is Anthropic’s terminal agent.

## During dotfiles install

```bash
bash install.sh --claude-code
```

Uses Anthropic’s installer (`curl … | bash`). If that fails, try:

```bash
npm install -g @anthropic-ai/claude-code
```

## Auth

- **Subscription:** `claude login`
- **API key:** add to **`shell/zshrc`** in the repo (symlinked as `~/.zshrc`):  
  `export ANTHROPIC_API_KEY=sk-ant-…`

If you use `npm install -g` and hit permission errors:

```bash
mkdir -p ~/.npm-global && npm config set prefix ~/.npm-global
```

`shell/zshrc` already prepends `~/.npm-global/bin` to `PATH`.

## Check

```bash
claude --version
claude doctor
```
