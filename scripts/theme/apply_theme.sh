#!/bin/bash

# Check if input file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_mp4_file>"
    exit 1
fi

MP4_FILE="$1"
BACKGROUND_DIR="/usr/share/sddm/themes/sddm-astronaut-theme/Backgrounds"
THEMES_DIR="/usr/share/sddm/themes/sddm-astronaut-theme/Themes"

# Get the directory where the script itself is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ensure required directories exist
if [ ! -d "$BACKGROUND_DIR" ] || [ ! -d "$THEMES_DIR" ]; then
    echo "Required directories do not exist."
    exit 1
fi

sudo cp -f "$MP4_FILE" "$BACKGROUND_DIR/active.mp4"

# Convert MP4 to PNG (first frame)
sudo ffmpeg -y -i "$MP4_FILE" -vf "select=eq(n\,0)" -q:v 2 "$BACKGROUND_DIR/active.png"

# Copy the theme configuration
sudo cp -f "$SCRIPT_DIR/sddm_theme.conf" "$THEMES_DIR/custom.conf"

# Set background
sudo cp -f "$MP4_FILE" "$HOME/.wallpapers/active.mp4"

echo "Wallpaper applied to lock-screen, login-screen, background"
