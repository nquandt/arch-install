# System optimization (low-power vs performance)

## Install profiles

| Command | Use case |
|---------|----------|
| **`bash install.sh`** (default) | **Low-power / iGPU**: no Hyprland blur or animations, opaque Ghostty, Waybar without cava; **zram**, **sysctl**, **earlyoom**. |
| **`bash install.sh --performance`** | **Faster GPU / more RAM**: blur + shadows + animations, **cava** on Waybar, translucent Ghostty; **no** zram sysctl earlyoom; **earlyoom** is disabled if it was on. |
| **`PROFILE_PERFORMANCE=1 bash install.sh`** | Same as **`--performance`**. |

Combine flags: **`bash install.sh --performance --claude-code`**.

To **switch** a machine from performance → low-power, run **`bash install.sh`** again without **`--performance`** (re-applies sysctl/zram/earlyoom and low-power symlinks).

---

## What the default (low-power) `install.sh` does

| Tuning | Purpose |
|--------|---------|
| **`/etc/sysctl.d/99-lowpower-dotfiles.conf`** | Lower **swappiness** (with zram), gentler **dirty** ratios, **NMI watchdog off** |
| **zram-generator** | Compressed swap in RAM — faster than disk swap when memory is tight |
| **thermald** | Intel thermal management (helps sustained clocks without spikes) |
| **earlyoom** | Kills runaway processes before the system hard-locks when RAM is full |

After first install, **reboot once** so **zram0** swap appears (`swapon --show`).

### Disable earlyoom (if too aggressive)

```bash
sudo systemctl disable --now earlyoom
```

### Change zram size

Edit **`/etc/systemd/zram-generator.conf`** (repo copy: **`system/zram-generator.conf`**). Example caps swap at **6 GiB** compressed; adjust `zram-size` (see `man zram-generator.conf`).

---

## Hyprland (GPU / compositor)

Default **`hypr/hyprland.conf`**:

- **Blur off**, **shadows off**, **animations off** — big savings on iGPU.
- **Rounding 6** — cheap corners only.

Optional overrides go in **`hypr/hyprland.local.conf`** (sourced at end of main config).

Tweaks beyond **`--performance`**: edit **`hypr/hyprland.local.performance`** in the repo, then re-run **`bash install.sh --performance`** (or symlink that file to **`~/.config/hypr/hyprland.local.conf`**).

---

## Waybar

**Cava** (audio visualizer) was removed from the default bar — it polls audio and redraws constantly. To bring it back:

1. `sudo pacman -S cava`
2. Add **`"cava"`** back into **`modules-right`** in **`waybar/config`** (before or after **tray**).

---

## Ghostty

**`background-opacity = 1`** — opaque terminal avoids extra compositing. Lower it in **`ghostty/config`** only if you want transparency (costs GPU).

---

## Firefox (about:config)

Optional, reduces work on weak GPUs:

| Key | Value |
|-----|--------|
| `layers.acceleration.force-enabled` | `true` (if stable) |
| `gfx.webrender.all` | `true` |

Use **Reader mode** / limit open tabs on very low RAM.

---

## Further ideas (manual)

- **BIOS:** enable all power-saving CPU states; disable unused controllers.
- **`powertop --auto-tune`** — can make USB devices flaky; tune selectively.
- **GRUB kernel params** (tradeoffs): `intel_idle.max_cstate=4` etc. — test stability.
- **AMD iGPU:** `thermald` may do less; **`earlyoom`** + **zram** still help.

---

← [Documentation index](README.md)
