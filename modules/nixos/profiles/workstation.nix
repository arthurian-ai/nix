# modules/nixos/profiles/workstation.nix — shared system profile for physical Linux machines.
{
  pkgs,
  inputs,
  hostConfig,
  ...
}:
{
  imports = [
    ../base.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    inputs.agenix.nixosModules.default
    ../theme.nix
    ../stylix.nix
    ../noctalia.nix
    ../packages.nix
    ../hyprland.nix
    ../keyd.nix
    ../fonts.nix
    ../thunar.nix
    ../regreet.nix
    ../virtualization.nix
    ../tailscale.nix
    ../../shared/emacs.nix
  ];

  # ── User extras for workstations ──────────────────────────────────
  users.users.${hostConfig.username}.extraGroups = [
    "libvirtd"
    "video"
  ];

  # ── Nix caches ────────────────────────────────────────────────────
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  # ── Bluetooth (for noctalia shell) ────────────────────────────────
  hardware.bluetooth.enable = true;

  # ── Boot ──────────────────────────────────────────────────────────
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ── Desktop portals ──────────────────────────────────────────────
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # ── Printing ─────────────────────────────────────────────────────
  services.printing.enable = true;

  # ── Home Manager wiring ──────────────────────────────────────────
  home-manager = {
    extraSpecialArgs = { inherit inputs hostConfig; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  system.stateVersion = "25.11";
}
