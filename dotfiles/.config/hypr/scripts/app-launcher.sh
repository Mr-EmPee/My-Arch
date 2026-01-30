#!/usr/bin/env bash
set -euo pipefail

DESKTOP_FILES=(
  "/usr/share/applications/brave-browser.desktop"
)

DESKTOP_DIRS=(
  "$HOME/.local/share/applications"
)

paths=()

for f in "${DESKTOP_FILES[@]}"; do
  paths+=("$f")
done

for dir in "${DESKTOP_DIRS[@]}"; do
  for f in "$dir"/*.desktop; do
    [[ -e "$f" ]] || continue
    paths+=("$f")
  done
done

names=()
ids=()

for f in "${paths[@]}"; do
  [[ -f "$f" ]] || continue

  # Best-effort Name= extraction (non-localized)
  name="$(awk -F= '$1=="Name"{print $2; exit}' "$f" | sed 's/[[:space:]]\+$//')"
  [[ -n "${name:-}" ]] || name="$(basename "$f" .desktop)"

  id="$(basename "$f" .desktop)"

  names+=("$name")
  ids+=("$id")
done

# Ask rofi to return the index of the chosen line
index="$(
  printf '%s\n' "${names[@]}" | rofi -dmenu -i -p "Apps" -format 'i'
)" || exit 0

[[ -n "$index" ]] || exit 0

# rofi returns 0-based index
chosen_id="${ids[$index]:-}"

nohup gtk-launch "$chosen_id" >/dev/null 2>&1 & disown
