#!/bin/sh

# Drivers
sudo pacman -S intel-media-driver
sudo systemctl enable bluetooth

# Audio
sudo pacman -S alsa-utils pipewire wireplumber pipewire-jack pipewire-pulse

# D-Bus
sudo pacman -S xdg-desktop-portal xdg-desktop-portal-gtk \
  gnome-keyring libsecret

# Hyprland
sudo pacman -S hyprland \
  swww \
  hyprlock \
  hyprpolkitagent \
  xdg-desktop-portal-hyprland

systemctl --user enable hyprpolkitagent.service

# Hyprpanel
sudo pacman -S brightnessctl hyprpicker power-profiles-daemon pacman-contrib
yay -S ags-hyprpanel-git

# Wayland
sudo pacman -S rofi-wayland

# Theming
sudo pacman -S nwg-look papirus-icon-theme \
  noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-jetbrains-mono-nerd

# Screenshot
sudo pacman -S grim slurp
yay -S wayfreeze-git

# Netowrk-Manager
sudo pacman -S network-manager-applet \
  webkit2gtk-4.1 \
  libnma-gtk4 networkmanager-openvpn \
  networkmanager-openconnect \
  networkmanager-vpnc

# SDDM
sudo pacman -S sddm
yay -S sddm-astronaut-theme

sudo sed -i 's/^Current=.*/Current=sddm-astronaut-theme/' /usr/lib/sddm/sddm.conf.d/default.conf
sudo sed -i 's/^ConfigFile=.*/ConfigFile=Themes\/hyprland_kath.conf/' /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop

sudo systemctl enable sddm

# Apps
sudo pacman -S kitty \
  firefox \
  stow
