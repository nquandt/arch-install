#!/bin/sh
# Screen record (needs: wl-screenrec, slurp, dunst)
if pidof wl-screenrec >/dev/null 2>&1; then
  killall -INT wl-screenrec 2>/dev/null
  notify-send "Recording stopped"
  exit 0
fi
out=$(slurp) || exit 1
mkdir -p "$HOME/Videos/screenrec"
f="$HOME/Videos/screenrec/video-$(date +%F_%H%M).mp4"
wl-screenrec -g "$out" -f "$f" &
notify-send "Recording → $f"
