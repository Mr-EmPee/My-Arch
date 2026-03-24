#!/usr/bin/env bash

# Start mpvpaper in background
mpvpaper -vs -o "no-audio loop" --layer overlay '*' ~/.wallpapers/active.mp4 &
MPVPAPER_PID=$!

sleep 0.35

# Run hyprlock (blocking)
hyprlock

# Kill only the mpvpaper we started
if kill -0 "$MPVPAPER_PID" 2>/dev/null; then
    kill "$MPVPAPER_PID"
fi
