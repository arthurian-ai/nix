# modules/nixos/profiles/vm.nix — shared system profile for Linux VMs.
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
    ../theme.nix
    ../packages.nix
    ../security-packages.nix
    ../keyd.nix
    ../fonts.nix
    ../stylix.nix
    ../thunar.nix
  ];

  # ── Home Manager wiring ──────────────────────────────────────────
  home-manager = {
    extraSpecialArgs = { inherit inputs hostConfig; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  # ── Extra VM packages ────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    neovim
  ];

  system.stateVersion = "25.11";
}
