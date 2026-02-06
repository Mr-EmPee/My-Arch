#!/usr/bin/env bash

active_class=$(hyprctl activewindow -j | jq -r '.class')

if [[ "$active_class" == "Alacritty" ]]; then
    SESSION="main"

    windows=$(tmux list-windows -t "$SESSION" 2>/dev/null | wc -l)

    if [[ "$windows" -le 1 ]]; then
        exit 0
    fi

    tmux kill-window -t "$SESSION:$(tmux display-message -p '#I')"
    exit 0
fi

if [[ "$active_class" == "discord" ]]; then
    exit 0
fi

if [[ "$active_class" == "teams-for-linux" ]]; then
    exit 0
fi

hyprctl dispatch killactive

