#!/usr/bin/env bash

set -u

log_file="${XDG_RUNTIME_DIR:-/tmp}/hypr-wallpaper.log"
runtime_dir="${XDG_RUNTIME_DIR:-/tmp}"
wallpaper_pid_file="$runtime_dir/hypr-wallpaper.pid"
lock_marker="$runtime_dir/hypr-wallpaper-locking"

log() {
    printf '%(%F %T)T [lockscreen] %s\n' -1 "$*" >>"$log_file"
}

stop_overlay() {
    rm -f "$lock_marker"
    if kill -0 "$overlay_pid" 2>/dev/null; then
        kill "$overlay_pid"
        wait "$overlay_pid" 2>/dev/null || true
    fi
    log "lockscreen overlay stopped (pid=$overlay_pid)"
}

touch "$lock_marker"
if [[ -r "$wallpaper_pid_file" ]]; then
    read -r wallpaper_pid <"$wallpaper_pid_file" || true
    if [[ "${wallpaper_pid:-}" =~ ^[0-9]+$ ]]; then
        kill -CONT "$wallpaper_pid" 2>/dev/null || true
    fi
fi
log "lock transition marked; resumed background wallpaper"

log "starting overlay wallpaper (auto-stop disabled)"
gslapper -v -o "no-audio loop" --layer overlay '*' "$HOME/.wallpapers/active.mp4" &
overlay_pid=$!
log "overlay wallpaper started (pid=$overlay_pid)"
trap stop_overlay EXIT INT TERM

# Allow the overlay surface to be mapped before hyprlock takes focus.
sleep 0.5
log "starting hyprlock"
hyprlock
lock_status=$?
log "hyprlock exited (status=$lock_status)"
exit "$lock_status"
