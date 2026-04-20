#!/usr/bin/env bash

BAT_PATH="/sys/class/power_supply/BAT0"

if [ ! -d "$BAT_PATH" ]; then
  BAT_PATH=$(find /sys/class/power_supply/ -maxdepth 1 -name "BAT*" | head -n 1)
fi

[ -z "$BAT_PATH" ] && exit 1

while true; do
  capacity=$(cat "$BAT_PATH/capacity")
  status=$(cat "$BAT_PATH/status")

  if [[ "$status" != "Charging" && "$capacity" -lt 6 ]]; then
    systemctl suspend
  fi

  sleep 60
done
