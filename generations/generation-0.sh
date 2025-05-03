#!/bin/sh

# Drivers
sudo pacman -S intel-media-driver

# Audio
sudo pacman -S alsa-utils pipewire wireplumber pipewire-jack pipewire-pulse

# Fonts
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-jetbrains-mono-nerd

# D-Bus
sudo pacman -S xdg-desktop-portal xdg-desktop-portal-gtk \
  gnome-keyring libsecret

# Hyprland
sudo pacman -S hyprland \
  swww \
  hyprlock \
  hyprpolkitagent \
  xdg-desktop-portal-hyprland

# Hyprpanel
sudo pacman -S brightnessctl hyprpicker power-profiles-daemon pacman-contrib
yay -S ags-hyprpanel-git

# Wayland
sudo pacman -S rofi-wayland

# Theming
sudo pacman -S nwg-look papirus-icon-theme

# Screenshot
sudo pacman -S grim slurp
yay -S wayfreeze-git

# Recording
sudo pacman -S wf-recorder

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

# Service enable

sudo systemctl enable sddm
sudo systemctl enable bluetooth

# Apps
sudo pacman -S kitty \
  firefox \
  stow \
  btop \
  nautilus
