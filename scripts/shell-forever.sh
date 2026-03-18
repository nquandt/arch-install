#!/bin/sh
# Re-spawn login shell when it exits (tmux starter panes).
SHELL="${SHELL:-/bin/bash}"
while true; do
  case "$SHELL" in
    */bash|bash) "$SHELL" --login ;;
    */zsh|zsh)    "$SHELL" -l ;;
    *)            "$SHELL" ;;
  esac
done
