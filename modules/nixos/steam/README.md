# Steam Gaming Module

This directory contains the Steam gaming module for NixOS, providing declarative configuration for Steam and PC gaming on NixOS.

## Files

- `modules/nixos/steam.nix` - NixOS system-level configuration
- `home/nixos/steam.nix` - Home-manager user-level configuration

## Quick Start

### 1. Add to Your Host Configuration

In your host's `default.nix`, add the module import:

```nix
{
  imports = [
    # ... other imports
    ../../modules/nixos/steam.nix
  ];
  
  # Enable Steam with desired options
  custom.steam = {
    enable = true;
    remotePlay = true;
    firewall = true;
    steamController = true;
  };
}
```

### 2. Add Home-Manager Configuration (Optional but Recommended)

In your home-manager configuration (e.g., `home/nixos/default.nix`):

```nix
{
  imports = [
    # ... other imports  
    ../../home/nixos/steam.nix
  ];
  
  # Enable user-level Steam settings
  home.steam = {
    enable = true;
    proton = {
      enable = true;
      useDxvk = true;
      useVkd3d = true;
      esync = true;
    };
  };
}
```

## Configuration Options

### NixOS Options (custom.steam)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `enable` | bool | false | Enable Steam gaming module |
| `remotePlay` | bool | false | Enable Steam Remote Play support |
| `firewall` | bool | false | Open firewall ports for Steam networking |
| `steamController` | bool | false | Enable Steam Controller hardware support |
| `gamescope` | bool | false | Enable Gamescope session (Steam Deck-like) |
| `enableProton` | bool | false | Install ProtonUp-QT for managing Proton versions |

### Home-Manager Options (home.steam)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `enable` | bool | false | Enable user Steam configuration |
| `proton.enable` | bool | false | Enable Proton environment variables |
| `proton.useDxvk` | bool | false | Enable DXVK (DX11→Vulkan) |
| `proton.useVkd3d` | bool | false | Enable vkd3d (DX12→Vulkan) |
| `proton.esync` | bool | false | Enable ESync for better Wine performance |
| `proton.fsync` | bool | false | Enable FSync for better Wine performance |

## Features

### What's Included

1. **Steam Installation** - Installs Steam via `programs.steam`
2. **Steam Controller Support** - Configures `hardware.steam-hardware` for Steam Controllers, Steam Deck
3. **Gamescope Support** - Optional Steam Deck-like gaming session via Gamescope
4. **Firewall Configuration** - Opens required ports for Steam networking and Remote Play
5. **Proton/Wine Optimization** - Environment variables for DXVK, vkd3d, ESync, FSync

### What's NOT Included (Configure Separately)

- **GPU Drivers** - Configure NVIDIA/AMD/Intel drivers in your host's hardware configuration
- **Kernel Parameters** - Add `ibt=off` for NVIDIA cards if needed
- **Game-specific proton versions** - Use ProtonUp-QT (if enabled) or Steam's built-in tool

## GPU-Specific Notes

### NVIDIA

```nix
# In your hardware config or host
hardware = {
  nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;  # Use closed-source driver
  };
  opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
};
```

### AMD (RADV)

```nix
# AMD GPUs typically work out of the box with mesa
# Ensure these are in your config:
services.xserver.videoDrivers = ["amdgpu"];
```

### Intel

```nix
# For Intel integrated graphics
services.xserver.videoDrivers = ["i915"];
```

## Troubleshooting

### Steam Won't Launch

1. Check if you're in the `video` group: `groups | grep video`
2. Try running with `steam -console` to see error messages
3. Check NVIDIA kernel module: `lsmod | grep nvidia`

### Games Run Slowly

1. Enable DXVK and vkd3d in home.steam.proton
2. Enable ESync/FSync (see notes below)
3. Check your GPU drivers are properly installed
4. Try launching with `MANGOHUD=1 %command%` to monitor FPS

### ESync/FSync Not Working

ESync and FSync require increased file descriptor limits. Add to `/etc/security/limits.conf`:

```
* soft nofile 1048576
* hard nofile 1048576
```

Then log out and back in.

## References

- [NixOS Wiki: Steam](https://nixos.wiki/wiki/Steam)
- [NixOS Options: programs.steam](https://search.nixos.org/options?channel=unstable&query=programs.steam)
- [NixOS Options: hardware.steam-hardware](https://search.nixos.org/options?channel=unstable&query=hardware.steam-hardware)
- [Protondb](https://www.protondb.com/) - Game compatibility ratings
- [WineHQ](https://wiki.winehq.org/) - Wine/Proton troubleshooting

## Credits

Module created for arthurian-ai NixOS configuration.
