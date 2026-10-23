#!/usr/bin/env bash

# Pause playback for focused windows, but never during lockscreen startup or
# while locked: stopping a gslapper Wayland surface there can expose the
# desktop through a transparent lockscreen.
set -u

log_file="${XDG_RUNTIME_DIR:-/tmp}/hypr-wallpaper.log"
pid_file="${XDG_RUNTIME_DIR:-/tmp}/hypr-wallpaper.pid"
lock_marker="${XDG_RUNTIME_DIR:-/tmp}/hypr-wallpaper-locking"
cleaned_up=false

log() {
    printf '%(%F %T)T [wallpaper] %s\n' -1 "$*" >>"$log_file"
}

cleanup() {
    local status=$?
    if "$cleaned_up"; then
        return
    fi
    cleaned_up=true

    if kill -0 "${wallpaper_pid:-}" 2>/dev/null; then
        kill "$wallpaper_pid" 2>/dev/null || true
        wait "$wallpaper_pid" 2>/dev/null || true
    fi
    rm -f "$pid_file"
    log "gslapper exited (status=$status, pid=${wallpaper_pid:-unknown})"
}

log "starting gslapper (continuous playback; log=$log_file)"
printf '%s\n' "$$" >"$pid_file"
gslapper -o 'no-audio --loop-playlist shuffle' ALL "$HOME/.wallpapers/active.mp4" &
wallpaper_pid=$!
log "gslapper started (pid=$wallpaper_pid)"

trap cleanup EXIT INT TERM

last_state="unknown"

while kill -0 "$wallpaper_pid" 2>/dev/null; do
    # The marker is created before hyprlock starts, preventing a race where
    # the focused window pauses gslapper during the lockscreen transition.
    if [[ -e "$lock_marker" ]] || pgrep -x hyprlock >/dev/null 2>&1; then
        if [[ "$last_state" != "lockscreen" ]]; then
            kill -CONT "$wallpaper_pid" 2>/dev/null || true
            log "lockscreen transition detected; keeping wallpaper running"
            last_state="lockscreen"
        fi
        sleep 0.2
        continue
    fi

    active_window=$(hyprctl activewindow -j 2>/dev/null | jq -r '.class // empty' 2>/dev/null)
    ws=$(hyprctl -j activeworkspace 2>/dev/null | jq -r '.id' 2>/dev/null)

    all_floating=false
    if [[ "$ws" =~ ^-?[0-9]+$ ]]; then
        all_floating=$(hyprctl -j clients 2>/dev/null | jq -r --argjson ws "$ws" '
            [.[] | select(.workspace.id == $ws)] |
            length > 0 and all(.[]; .floating == true)
        ' 2>/dev/null)
    fi

    if [[ "$active_window" == "Alacritty" || "$all_floating" == "true" ]]; then
        active_window=""
    fi

    if [[ -z "$active_window" ]]; then
        if [[ "$last_state" != "desktop" ]]; then
            kill -CONT "$wallpaper_pid" 2>/dev/null || true
            log "desktop visible; resumed wallpaper"
            last_state="desktop"
        fi
    elif [[ "$last_state" != "window" ]]; then
        kill -STOP "$wallpaper_pid" 2>/dev/null || true
        log "active window '$active_window'; paused wallpaper"
        last_state="window"
    fi

    sleep 0.2
done

wait "$wallpaper_pid"
