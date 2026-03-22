# Architecture

## Overview

This flake uses a **data-driven** design: a single host inventory drives the
generation of all NixOS and Darwin system configurations.

## Directory Layout

```
.
├── flake.nix                   # Orchestrator — generates outputs from inventory
├── lib/
│   ├── hosts.nix               # Host inventory (data only)
│   ├── mk-nixos-host.nix       # NixOS system constructor
│   └── mk-darwin-host.nix      # Darwin system constructor
├── hosts/                      # Per-host entrypoints (hardware + overrides)
│   ├── desktop/
│   ├── thinkpad/
│   ├── kvm/
│   ├── parallels-vm/
│   └── mbp/
├── modules/
│   ├── nixos/
│   │   ├── base.nix            # Shared NixOS foundation
│   │   ├── profiles/
│   │   │   ├── workstation.nix  # Physical workstation profile
│   │   │   └── vm.nix          # VM profile
│   │   └── *.nix               # Feature modules (hyprland, keyd, etc.)
│   ├── darwin/
│   │   ├── base.nix            # Shared Darwin foundation
│   │   └── *.nix               # Feature modules (homebrew, fonts, etc.)
│   └── shared/
│       └── emacs.nix           # Cross-platform modules
├── home/
│   ├── profiles/
│   │   ├── base.nix            # Shared HM defaults
│   │   ├── linux-workstation.nix
│   │   ├── vm.nix
│   │   └── darwin.nix
│   ├── desktop/                # Thin wrapper → linux-workstation profile
│   ├── laptop/                 # Thin wrapper → linux-workstation profile
│   ├── vm/                     # Thin wrapper → vm profile
│   ├── darwin/                 # Thin wrapper → darwin profile
│   ├── shared/                 # Cross-platform HM modules
│   └── nixos/                  # Linux-only HM modules
├── overlays/
│   ├── dnsenum.nix             # Overlay function (final: prev: shape)
│   └── default.nix             # NixOS module wrapper for the overlay
├── reference/
│   ├── inactive-hosts/         # Archived hosts (xps, utm-vm, vm-common)
│   └── *.nix                   # Security package reference lists
└── secrets/
    └── secrets.nix
```

## How It Works

1. **`lib/hosts.nix`** defines every active host as an attribute set with
   metadata: `kind`, `system`, `username`, `hostname`, `role`, and feature
   flags like `isLaptop`, `hasNvidia`, `monitors`.

2. **`flake.nix`** imports the inventory, merges `_defaults` into each host,
   partitions by `kind` (nixos vs darwin), and maps the appropriate constructor
   over each partition.

3. **Constructors** (`mk-nixos-host.nix`, `mk-darwin-host.nix`) are thin
   wrappers around `nixosSystem` / `darwinSystem` that pass `hostConfig` via
   `specialArgs`.

4. **Host entrypoints** (`hosts/<name>/default.nix`) import their hardware
   config and one system profile, then add machine-specific overrides.

5. **System profiles** (`modules/*/profiles/`) compose feature modules and set
   role-wide defaults. Host-specific branches use `hostConfig` fields.

6. **Home Manager profiles** (`home/profiles/`) follow the same pattern:
   `base.nix` for universal defaults, then role-specific profiles that add
   the right programs and settings.

## Active Hosts

| Name          | Kind   | System          | Role        |
|---------------|--------|-----------------|-------------|
| desktop       | nixos  | x86_64-linux    | workstation |
| thinkpad      | nixos  | x86_64-linux    | workstation |
| kvm           | nixos  | x86_64-linux    | vm          |
| parallels-vm  | nixos  | aarch64-linux   | vm          |
| mbp           | darwin | aarch64-darwin  | darwin      |

## Archived Hosts

Moved to `reference/inactive-hosts/`:
- **xps** — old laptop, not in flake outputs
- **utm-vm** — empty placeholder
- **vm-common** — referenced missing hardware-configuration.nix

## Overlays

The flake exports `overlays.default` (the dnsenum Perl fix). Hosts that need
it import `../../overlays` which is a NixOS module applying
`self.overlays.default`.

## Adding a New Host

1. Add an entry to `lib/hosts.nix`.
2. Add the host module path to `hostModules` in `flake.nix`.
3. Create `hosts/<name>/default.nix` importing hardware-config + a profile.
4. Set any machine-specific overrides and wire up Home Manager.
