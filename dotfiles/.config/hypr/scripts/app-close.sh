#!/usr/bin/env bash

active_class=$(hyprctl activewindow -j | jq -r '.class')

if [[ "$active_class" == "Alacritty" ]]; then
    windows=$(zellij action query-tab-names | wc -l)

    if [[ "$windows" -le 1 ]]; then
        exit 0
    fi

    zellij action close-tab
    exit 0
fi

if [[ "$active_class" == "discord" ]]; then
    exit 0
fi

if [[ "$active_class" == "teams-for-linux" ]]; then
    exit 0
fi

hyprctl dispatch killactive

