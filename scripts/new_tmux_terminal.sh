#!/bin/sh
export LANG="${LANG:-en_US.UTF-8}"
SESSION=main
first_tmux_session() {
  tmux new-session -ds "$SESSION" "$HOME/.config/scripts/zsh-forever.sh" \; attach -t "$SESSION"
}
while true; do
  tmux attach -t "$SESSION" 2>/dev/null || first_tmux_session
done
