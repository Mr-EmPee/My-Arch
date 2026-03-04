#!/usr/bin/env bash
set -euo pipefail

# Favorites (label -> command)
FAV_LABELS=(
  "Restore terminal"
)
FAV_CMDS=(
  "alacritty && hyprctl dispatch workspace 2"
)

SELF="$(readlink -f "$0")"

# --- rofi script mode backend for favorites ---
# rofi calls:
#   script (no args)          -> print entries
#   script "<selected entry>" -> execute selection
if [[ "${1-}" == "--favorites" ]]; then
  if [[ $# -eq 1 ]]; then
    # list entries
    printf '%s\n' "${FAV_LABELS[@]}"
    exit 0
  fi

  sel="$2"
  for i in "${!FAV_LABELS[@]}"; do
    if [[ "$sel" == "${FAV_LABELS[$i]}" ]]; then
      nohup bash -lc "${FAV_CMDS[$i]}" >/dev/null 2>&1 &
      exit 0
    fi
  done
  exit 0
fi

# --- main: one rofi window with combined Favorites + drun apps ---
rofi -show combi \
  -modi "combi,favorites:${SELF} --favorites,drun" \
  -combi-modi "favorites,drun"
