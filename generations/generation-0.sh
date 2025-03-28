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

# Hyprland + Essentials Installation
sudo pacman -S sddm \
  hyprland \
  swww \
  hyprlock \
  hyprpolkitagent \
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

# Netowrk-Manager vpn plugins
sudo pacman -S webkit2gtk-4.1 \
  libnma-gtk4 networkmanager-openvpn \
  networkmanager-openconnect \
  networkmanager-vpnc

# SDDM Theme
yay -S sddm-astronaut-theme
# Replace active sddm theme
sudo sed -i 's/^Current=.*/Current=sddm-astronaut-theme/' /usr/lib/sddm/sddm.conf.d/default.conf
sudo sed -i 's/^ConfigFile=.*/ConfigFile=Themes\/hyprland_kath.conf/' /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop

# Services
sudo systemctl enable sddm
sudo systemctl enable bluetooth

systemctl --user enable hyprpolkitagent.service
