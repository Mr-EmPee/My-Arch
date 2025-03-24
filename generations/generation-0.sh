#!/bin/sh

echo "This script is performing the following actions:"
echo "- Install SDDM"
echo "- Install Hyprland"
echo "- Install Dekstop-Portals"
echo "- Install Keyring"
echo "- Install Intel Graphics Drivers"
echo "- Install Audio & Screen utils"
echo "- Install Stow"
echo "- Install Hyprpanel"
echo "- Install rofi"
echo "- Install Kitty"

# Hyprland Installation
sudo pacman -S sddm \
	       hyprland \
	       noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-jetbrains-mono-nerd \
	       nwg-look papirus-icon-theme \
	       xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
	       gnome-keyring libsecret \
	       alsa-utils pipewire wireplumber pipewire-jack pipewire-pulse \
	       intel-media-driver \
	       rofi-wayland \
	       stow \
	       kitty

# HyPrPanel Installation
sudo pacman -S network-manager-applet brightnessctl wf-recorder hyprpicker power-profiles-daemon pacman-contrib
yay -S ags-hyprpanel-git

# Services
sudo systemctl enable sddm
sudo systemctl enable bluetooth
