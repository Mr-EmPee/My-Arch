#!/usr/bin/env bash

# Launch mpvpaper in the background and save its PID
mpvpaper -o 'no-audio --loop-playlist shuffle' ALL ~/.wallpapers &
clientPid=$!
echo "Launched mpvpaper with PID $clientPid"

# Track last state
last_state="none"

while true; do
    active_info=$(hyprctl activewindow)

    active_window=$(echo "$active_info" | awk '/Window/{print $2}')
    opacity=$(echo "$active_info" | awk '/opacity/{print $2}')

    if [ -z "$active_window" ]; then
        if [ "$last_state" != "none" ]; then
            echo "No active window - resuming mpvpaper"
            kill -CONT "$clientPid"
        fi
        last_state="none"
    else
        # Default opacity fallback (in case parsing fails)
        opacity=${opacity:-1.0}

        # Only pause if window is effectively opaque
        is_opaque=$(awk "BEGIN {print ($opacity >= 0.95)}")

        if [ "$is_opaque" -eq 1 ]; then
            if [ "$last_state" == "none" ]; then
                echo "Opaque window active - pausing mpvpaper"
                kill -STOP "$clientPid"
            fi
            last_state="active"
        else
            if [ "$last_state" != "none" ]; then
                echo "Transparent window - resuming mpvpaper"
                kill -CONT "$clientPid"
            fi
            last_state="none"
        fi
    fi

    sleep 0.2
done
