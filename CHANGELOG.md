# Changelog

All notable changes to this NixOS/nix-darwin configuration are documented here.
This fork is maintained by the arthurian-ai account; the upstream repository is
[curtisjm/nix](https://github.com/curtisjm/nix).

---

## [Unreleased] — arthurian-ai fork changes

### Added

#### XPS Host Registration (`flake.nix`)

- Added `xps` to `nixosConfigurations` with a dedicated `xpsConfig`
  (`hostname = "nixos-xps"`, `username = "curtis"`) — XPS was previously
  missing from flake outputs, making `nixos-rebuild --flake .#xps` non-functional

#### Security Hardening Modules (`modules/nixos/`)

- **`ssh.nix`** — Configurable OpenSSH server hardening module (`custom.ssh`):
  *(formerly `ssh-hardening.nix` / `custom.sshHardening` — renamed for consistency)*
  - Restricts ciphers to ChaCha20-Poly1305 and AES-GCM variants
  - Restricts MACs to ETMAC variants (encrypt-then-MAC)
  - Restricts key exchange to Curve25519 and DH group 16/18
  - Disables password authentication and root login by default
  - Disables X11 forwarding, TCP forwarding, and agent forwarding
  - Sets `MaxAuthTries = 3`, `LoginGraceTime = 30`, idle disconnect in 5 min
  - Opens the configured SSH port in the firewall automatically

- **`firewall.nix`** — Configurable firewall module (`custom.firewall`):
  - Enables `networking.firewall` with configurable TCP/UDP port allowlists
  - Adds iptables rules to drop invalid, NULL, XMAS, SYN-FIN, and SYN-RST
    packet combinations at the kernel level
  - Optional ICMP ping blocking and connection logging

- **`fail2ban.nix`** — Fail2ban intrusion prevention module (`custom.fail2ban`):
  - SSH jail enabled by default (watches `sshd` logs)
  - Optional nginx jails (`nginx-http-auth`, `nginx-nohome`)
  - Incremental ban times with 2x multiplier up to 48 hours
  - Ignores loopback addresses; configurable allowlist of trusted IPs

- **`auto-updates.nix`** — Automatic NixOS system maintenance (`custom.autoUpdates`):
  *(formerly `auto-update.nix` / `custom.autoUpdate` — renamed for consistency)*
  - Configurable automatic `nixos-rebuild` (disabled on ThinkPad by default —
    users prefer manual control on laptops)
  - Nix store garbage collection on a weekly schedule, keeping 30 days of
    generations
  - Enables `nix.settings.auto-optimise-store` to dedup hard links after builds

#### ThinkPad Power Management (`modules/nixos/thinkpad-power.nix`)

- New module `custom.thinkpadPower` for ThinkPad X1 and similar laptops:
  - **TLP** with CPU performance/powersave governor profiles per AC/BAT state
  - **Battery charge thresholds** (default 75% start / 80% stop) via
    `thinkpad_acpi` — extends long-term battery health
  - **Intel HWP** energy/performance policy set per power state
  - **WiFi power saving** disabled on AC, enabled on battery
  - **PCIe ASPM** `powersupersave` on battery
  - **thermald** Intel thermal management daemon always enabled
  - **fwupd** for LVFS firmware updates (ThinkPad BIOS/EC/dock firmware)
  - **TPM2** enabled (required for EFI capsule updates via fwupd)
  - **Lid suspend** via logind with `HoldoffTimeoutSec=2s` to prevent
    accidental wake
  - Mutual exclusion between TLP and `power-profiles-daemon`

#### Common Configuration Module (`modules/nixos/common.nix`)

- Extracted repeated configuration patterns shared by all NixOS hosts into a
  single `common.nix` module:
  - `nix.settings.experimental-features = "nix-command flakes"`
  - `nixpkgs.config.allowUnfree = true`
  - Locale, timezone, and `i18n.extraLocaleSettings` from `hostConfig`
  - `zsh` as the default user shell
  - `networking.hostName` and `NetworkManager` from `hostConfig`
  - Pipewire audio (PulseAudio disabled, rtkit enabled)
  - Firefox declarative program management
  - Base system packages (`git`, `tmux`)
  - Primary user account with `networkmanager` and `wheel` groups

### Fixed

#### ThinkPad X1 13th Gen (`hosts/thinkpad/`)

- **Missing firmware**: Added `hardware.enableRedistributableFirmware = true`
  and `hardware.enableAllFirmware = true` in `thinkpad-power.nix` to ensure
  Intel AX211 WiFi/Bluetooth and other peripheral firmware are present
- **Intel Xe graphics**: Added `intel-media-driver` (VAAPI/iHD) and
  `intel-compute-runtime` (OpenCL) to `hardware.graphics.extraPackages` for
  hardware video acceleration on Intel Arc/Xe GPUs
- **Kernel modules**: Explicitly load `thinkpad_acpi` (battery thresholds,
  fan control, hotkeys) and `intel_pstate` (CPU frequency scaling) via
  `boot.kernelModules` in `hardware-configuration.nix`
- **Lid suspend**: Was entirely commented out in the original config — now
  active via `thinkpad-power.nix` which configures `services.logind` with
  proper suspend-on-lid-close behavior
- **XDG portal**: Changed `extraPortals` from `xdg-desktop-portal-gtk` (wrong
  for Hyprland) to both `xdg-desktop-portal-hyprland` (native Wayland/Hyprland
  integration for file pickers and screenshots) and `xdg-desktop-portal-gtk`
  (fallback for GTK apps)
- **Hostname collision**: ThinkPad hostname changed from `"nixos"` (same as VMs)
  to `"thinkpad"` — prevents network identification conflicts
- **PSR option**: Moved Intel PSR workaround (`xe.enable_psr=0`) from an
  inline comment in `default.nix` into a proper `disableIntelPSR` option on the
  `custom.thinkpadPower` module; toggled via `thinkpad-power.nix` kernel params
- **Security modules**: Wired `ssh`, `firewall`, `fail2ban`, and `auto-updates`
  (GC-only mode) into the ThinkPad host configuration

---

## Upstream history summary

The following is a condensed summary of the original upstream (`curtisjm/nix`)
history. Full commit log available via `git log`.

### Multi-machine architecture

The configuration supports six targets across two operating systems:

| Target | OS | Architecture | Notes |
|---|---|---|---|
| `thinkpad` | NixOS | x86_64 | ThinkPad X1 Carbon 13th Gen (primary laptop) |
| `desktop` | NixOS | x86_64 | Desktop PC |
| `kvm` | NixOS | x86_64 | KVM/QEMU virtual machine |
| `parallels-vm` | NixOS | aarch64 | Parallels Desktop on Apple Silicon |
| `utm-vm` | NixOS | aarch64 | UTM on Apple Silicon |
| `mbp` | macOS (nix-darwin) | aarch64 | MacBook Pro (Apple Silicon) |

### Key upstream features

- **Stylix** integration for system-wide theming (nord, gruvbox, tokyonight,
  rose-pine, ayu, kanagawa color schemes)
- **Hyprland** Wayland compositor on ThinkPad with noctalia shell, hypridle,
  hyprlock (with fingerprint auth), swappy screenshots
- **nvf** declarative Neovim configuration
- **agenix** secrets management for WiFi credentials (eduroam)
- **Tailscale** VPN with `--shields-up` flag
- **Custom keyd module** with ThinkPad meta layer and capslock-to-ctrl/esc
- **Home-manager** modules for shell tools (zsh, atuin, starship, zoxide,
  eza, fzf, bat), editors, and GUI applications
- **Virtual machine support** with SPICE/QEMU guest agents, Parallels Tools
