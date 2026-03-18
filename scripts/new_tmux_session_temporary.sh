#!/bin/sh
# Same idea as upstream missing script: always a fresh tmux session.
export LANG="${LANG:-en_US.UTF-8}"
exec sh ~/.config/scripts/new_tmux_session.sh
