#!/bin/sh

if [ "$EUID" -eq 0 ]; then
    echo "❌ Do not run this script as root or with sudo."
    echo "Run it as your normal user. The script will ask for sudo when needed."
    exit 1
fi

# Get the directory where the script itself is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Dotfiles
sudo pacman -S stow

stow -v -t ~ -d "$SCRIPT_DIR/../dotfiles" .

# System Time
sudo timedatectl set-ntp true

# Audio
sudo pacman -S alsa-utils pipewire wireplumber pipewire-jack pipewire-pulse pipewire-alsa

# Fonts
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-jetbrains-mono-nerd

# D-Bus
sudo pacman -S xdg-desktop-portal xdg-desktop-portal-gtk gnome-keyring libsecret

# Hyprland
sudo pacman -S uwsm \
  hyprland \
  hyprlock \
  hyprpolkitagent \
  xdg-desktop-portal-hyprland \
  xorg-xrandr \
  brightnessctl \
  wl-clipboard \
  wl-clip-persist \
  ttf-jetbrains-mono-nerd \
  qt5-wayland qt6-wayland

# Waybar
sudo pacman -S waybar power-profiles-daemon 

# Wallpaper
yay --answerdiff None --answerclean None --removemake -S mpvpaper

# Wayland
sudo pacman -S rofi

# Theming
sudo pacman -S nwg-look papirus-icon-theme

# Screenshot
sudo pacman -S grim slurp
yay --answerdiff None --answerclean None --removemake -S wayfreeze-git

# Recording
sudo pacman -S wf-recorder

# Notification
sudo pacman -S mako

# Others reguired by scripts
sudo pacman -S jq

# Netowrk-Manager
sudo pacman -S network-manager-applet \
  webkit2gtk-4.1 \
  libnma-gtk4 networkmanager-openvpn \
  networkmanager-openconnect \
  networkmanager-openvpn

# SDDM
sudo pacman -S sddm
yay --answerdiff None --answerclean None --removemake -S sddm-astronaut-theme

sudo sed -i 's/^Current=.*/Current=sddm-astronaut-theme/' /usr/lib/sddm/sddm.conf.d/default.conf
sudo sed -i 's/^ConfigFile=.*/ConfigFile=Themes\/custom.conf/' /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop

bash "$SCRIPT_DIR/../scripts/theme/apply_theme.sh" "$SCRIPT_DIR/files/wallpaper.mp4"

sudo systemctl enable sddm

# Bluetooth
sudo pacman -S blueman bluez-utils
sudo systemctl enable bluetooth

# Terminal
sudo pacman -S alacritty zellij ttf-hack-nerd

# Apps
sudo pacman -S btop nautilus
