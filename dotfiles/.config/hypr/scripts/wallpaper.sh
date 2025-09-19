#!/usr/bin/env bash

# Launch mpvpaper in the background and save its PID
mpvpaper -o 'no-audio --loop-playlist shuffle' ALL ~/.wallpapers &
clientPid=$!
echo "Launched mpvpaper with PID $clientPid"

# Track last state
last_state="none"

while true; do
    # Get current active window ID (empty if none)
    active_window=$(hyprctl activewindow | awk '{print $2}')

    if [ -z "$active_window" ]; then
        # No active window
        if [ "$last_state" != "none" ]; then
            echo "No active window - resuming mpvpaper"
            kill -CONT "$clientPid"
        fi
        last_state="none"
    else
        # There is an active window
        if [ "$last_state" == "none" ]; then
            echo "Window is active - pausing mpvpaper"
            kill -STOP "$clientPid"
        fi
        last_state="active"
    fi

    sleep 0.2  # adjust polling interval
done
