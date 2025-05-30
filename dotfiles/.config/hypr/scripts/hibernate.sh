#!/usr/bin/env bash

clientPid=$(hyprctl activewindow -j | grep '"pid"' | awk '{print $2}' | tr -d ',')

# Check if PID was found
if [[ -z "$clientPid" ]]; then
  echo "No active window PID found to hibernate"
  exit 1
fi

processState=$(ps -o state= -p "$clientPid" | awk '{print $1}')

if [[ "$processState" == "T" ]]; then
  echo "Process $clientPid is stopped. Sending CONT..."
  kill -CONT "$clientPid"
  notify-send "Window Resumed" "Process $clientPid has been resumed." \
    -i media-playback-start \
    -a "Window Freezer" \
    -t 5000
else
  echo "Process $clientPid is running. Sending STOP..."
  kill -STOP "$clientPid"
  notify-send "Window Frozen" "Process $clientPid has been hibernated." \
    -i media-playback-pause \
    -a "Window Freezer" \
    -t 5000
fi
