#!/bin/sh

if [ "$EUID" -eq 0 ]; then
    echo "❌ Do not run this script as root or with sudo."
    echo "Run it as your normal user. The script will ask for sudo when needed."
    exit 1
fi

# Dotfiles
sudo pacman -S stow
stow -d .. -t ~ dotfiles

# System & Drivers
sudo pacman -S intel-media-driver os-prober
sudo timedatectl set-ntp true

# Audio
sudo pacman -S alsa-utils pipewire wireplumber pipewire-jack pipewire-pulse pipewire-alsa

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
  xdg-desktop-portal-hyprland \
  xorg-xrandr

# Hyprpanel
sudo pacman -S brightnessctl hyprpicker power-profiles-daemon pacman-contrib
yay --answerdiff None --answerclean None --removemake -S ags-hyprpanel-git

# Wayland
sudo pacman -S rofi

# Theming
sudo pacman -S nwg-look papirus-icon-theme

# Screenshot
sudo pacman -S grim slurp
yay --answerdiff None --answerclean None --removemake -S wayfreeze-git

# Recording
sudo pacman -S wf-recorder

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
sudo sed -i 's/^ConfigFile=.*/ConfigFile=Themes\/hyprland_kath.conf/' /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop

# Service enable
sudo systemctl enable sddm
sudo systemctl enable bluetooth

# Apps
sudo pacman -S kitty \
  firefox \
  btop \
  nautilus
