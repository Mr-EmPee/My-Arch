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

cat <<'EOF'

╭──────────────────────────────────────────────╮
│              POST-INSTALL STEPS              │
╰──────────────────────────────────────────────╯

This script will continue the user-level setup for the Arch system.

After rebooting, you can log in with:

    username: empee
    password: empee

Then build and install yay manually with:

    cd ~/yay-bin
    makepkg -si

Next, this script will run:

    cd /home/empee/My-Arch
    generations/generation-0.sh
    stow --no-folding dotfiles

Finally, apply the Rofi and GTK themes manually using:

    nwg-look

EOF