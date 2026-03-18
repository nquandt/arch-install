# Arch Linux install → Hyprland desktop (one path)

**Part 1** — minimal system from the ISO (no GUI).  
**Part 2** — after reboot: **clone this repo** and run **`bash install.sh`** for Hyprland, Ghostty, Neovim, tmux, audio, SDDM, etc.

Replace `YOURUSER`, `yourhostname`, `/dev/sdX`, and the **git URL** with yours.

---

## Part 1 — From ISO to first boot

### 1. Partition

EFI + swap + root (GPT labels optional).

### 2. Format & mount

```bash
mkfs.fat -F 32 /dev/sdX1
mkswap /dev/sdX2 && swapon /dev/sdX2
mkfs.ext4 /dev/sdX3
mount /dev/sdX3 /mnt
mount --mkdir /dev/sdX1 /mnt/boot
```

### 3. Pacstrap

Includes everything **install.sh** needs on first login (`git`, `base-devel` for building paru, NetworkManager):

```bash
pacstrap -K /mnt base linux linux-firmware base-devel git networkmanager neovim \
  sudo zsh
```

*(Optional: `amd-ucode` or `intel-ucode` — add to the line above for CPU microcode.)*

### 4. fstab & chroot

```bash
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```

### 5. Timezone & locale

```bash
timedatectl set-timezone America/Chicago
timedatectl set-ntp true
# Uncomment en_US.UTF-8 in /etc/locale.gen, then:
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
```

### 6. Hostname & root password

```bash
echo "yourhostname" > /etc/hostname
passwd
```

### 7. Bootloader (systemd-boot)

```bash
bootctl install
```

`/boot/loader/entries/arch.conf`:

```
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=UUID=ROOT_UUID rw
```

`/boot/loader/loader.conf`: `default arch.conf`, `timeout 3`

### 8. Sudo + user (in chroot)

```bash
pacman -S sudo
EDITOR=nvim visudo   # uncomment %wheel ALL=(ALL:ALL) ALL

useradd -m -G wheel -s /usr/bin/zsh YOURUSER
passwd YOURUSER
```

### 9. Network & reboot

```bash
systemctl enable NetworkManager
exit
umount -R /mnt
reboot
```

---

## Part 2 — Dotfiles (Hyprland stack)

Log in as **YOURUSER** (TTY or any session). Network:

```bash
sudo systemctl start NetworkManager
nmcli device wifi list
nmcli device wifi connect "SSID" password "secret"
sudo pacman -Syu
```

### Clone **this** repository

```bash
cd ~
git clone https://github.com/YOUR_GITHUB/arch-install.git
cd arch-install
```

*(Use your real repo URL.)*

### Run the installer

```bash
bash install.sh
# Faster machine (dGPU / lots of RAM):  bash install.sh --performance
```

**With [Claude Code](https://docs.anthropic.com/en/docs/claude-code/setup)** (Anthropic CLI, optional):

```bash
bash install.sh --claude-code
# same: INSTALL_CLAUDE_CODE=1 bash install.sh
```

After install, authenticate: `claude login` or `export ANTHROPIC_API_KEY=…`.

What **install.sh** does:

- Builds **paru** if missing.
- **Default:** low-power tuning (zram, sysctl, earlyoom) + minimal compositing.
- **`--performance`:** blur/animations, Waybar **cava**, translucent Ghostty; skips zram/sysctl/earlyoom.
- Installs Hyprland, Waybar, wofi, SDDM, PipeWire, **Firefox**, Ghostty (AUR), Dunst, Neovim, tmux, zsh, starship, fonts, etc.
- **Super+B** → Firefox.

### Reboot

`install.sh` sets **zsh**, applies a **low-power sysctl profile**, **zram** swap, **thermald**, and **earlyoom**. **Reboot once** so zram activates. Details: **`docs/system-optimization.md`**.

```bash
sudo reboot
```

Log out/in once if you skipped the pacstrap `zsh` line so `chsh` can run after `install.sh`.

At **SDDM**, choose **Hyprland**. Then:

1. **tmux** — prefix `Ctrl+s`, then `I` to install TPM plugins.  
2. **nvim** — first launch pulls Lazy/Mason.  
3. **nwg-look** — optional, for GTK theme tweaks.

---

## AMD GPU only

If you use AMD and skipped Intel drivers, install Vulkan for games/VA-API:

```bash
sudo pacman -S vulkan-radeon libva-mesa-driver
```

---

## What you do *not* need before `install.sh`

No separate “post-install guide” run — **network + `sudo pacman -Syu` + clone + `bash install.sh`** is enough after Part 1.
