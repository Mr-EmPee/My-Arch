#!/bin/sh

# This script expect /mnt mounted with /boot as EFI partition

# Choose mirrors
reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacman -Sy

# Init system
pacstrap -K /mnt base linux

# Save current mouting layout
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

# Drivers
pacman -S linux-firmware sof-firmware intel-ucode intel-media-driver

# Bootloader
pacman -S grub efibootmgr os-prober

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg

# Minimal utils

pacman -S networkmanager
systemctl enable NetworkManager

pacman -S sudo
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# User account
useradd -m -G wheel -s /bin/bash empee
echo 'empee:empee' | chpasswd

pacman -S git base-devel man-db

git clone https://aur.archlinux.org/yay-bin.git /home/empee/yay-bin
chown -R empee:empee /home/empee/yay-bin

git clone https://github.com/Mr-EmPee/My-Arch.git /home/empee/My-Arch
chown -R empee:empee /home/empee/My-Arch

# Explain the command you need to execute