# System: audio, login, GTK, portals

## SDDM

Display manager — graphical login. **install.sh** enables **`sddm`**.

At login, pick **Hyprland** from the session menu.

## PipeWire

Audio stack: **pipewire**, **wireplumber**, PulseAudio/JACK compatibility.

**install.sh** enables user units: **pipewire**, **pipewire-pulse**, **wireplumber**.

Check: **`pactl info`** (should show PipeWire). Waybar’s pulse module and **pamixer** keybinds use this stack.

## Polkit

**polkit-kde-agent** runs on Hyprland login so GUI apps can ask for root (e.g. some installers).

## GTK / icons

**gsettings** on login sets **Adwaita-dark** + **Papirus-Dark**. Run **`nwg-look`** anytime to tweak GTK/Qt appearance.

## XDG / Wayland portals

**xdg-desktop-portal-hyprland** — screen share, file dialogs for Flatpak/sandboxed apps, etc.

**Qt Wayland** packages help Qt apps on Wayland.

## Intel / AMD video

**install.sh** tries **mesa**, **vulkan-intel**, **intel-media-driver** (soft-fail). Pure AMD: install **vulkan-radeon** etc. (see **arch-install.md**).
