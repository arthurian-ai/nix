# hosts/thinkpad/default.nix — hardware + machine-specific overrides only.
{
  config,
  pkgs,
  inputs,
  hostConfig,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-13th-gen
    ../../modules/nixos/profiles/workstation.nix
    ../../modules/nixos/networking.nix
  ];

  # ── Keyd (ThinkPad-specific meta remap) ────────────────────────────
  custom.keyd = {
    enable = true;
    enableThinkpadMeta = true;
  };

  # ── Theme ──────────────────────────────────────────────────────────
  custom.theme = {
    enable = true;
    colorScheme = "tokyonight";
    transparency = true;
  };

  # ── ThinkPad services ─────────────────────────────────────────────
  services.tuned.enable = true;
  services.upower.enable = true;
  services.fprintd.enable = true;

  # ── Home Manager ──────────────────────────────────────────────────
  home-manager.users.${hostConfig.username} = import ../../home/laptop;
}
