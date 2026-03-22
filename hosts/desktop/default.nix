# hosts/desktop/default.nix — hardware + machine-specific overrides only.
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
    ../../modules/nixos/profiles/workstation.nix
  ];

  # ── Keyd ───────────────────────────────────────────────────────────
  custom.keyd = {
    enable = true;
    # enableThinkpadMeta = true;
  };

  # ── Theme ──────────────────────────────────────────────────────────
  custom.theme = {
    enable = true;
    colorScheme = "rose-pine";
    transparency = true;
  };

  # ── NVIDIA ─────────────────────────────────────────────────────────
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
  hardware.graphics.enable = true;

  # ── Home Manager ──────────────────────────────────────────────────
  home-manager.users.${hostConfig.username} = import ../../home/desktop;
}
