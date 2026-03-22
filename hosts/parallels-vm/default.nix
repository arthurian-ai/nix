# hosts/parallels-vm/default.nix — Parallels VM on Apple Silicon.
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
    ../../modules/nixos/profiles/vm.nix
    ../../modules/nixos/sway.nix
  ];

  # ── Home Manager ──────────────────────────────────────────────────
  home-manager.users.${hostConfig.username} = import ../../home/vm;

  # ── Boot ──────────────────────────────────────────────────────────
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ── User extras ───────────────────────────────────────────────────
  users.users.${hostConfig.username}.extraGroups = [ "video" "render" ];

  # ── Extra packages ───────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    mesa-demos
  ];

  # ── Parallels hardware ───────────────────────────────────────────
  hardware.parallels.enable = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ mesa ];
  };
}
