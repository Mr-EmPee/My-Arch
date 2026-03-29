#!/usr/bin/env bash

mpvpaper -vs -o "no-audio loop" --layer overlay '*' ~/.wallpapers/active.mp4 &
MPVPAPER_PID=$!

sleep 0.5

hyprlock

kill "$MPVPAPER_PID"
