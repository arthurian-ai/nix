# home/profiles/vm.nix — HM profile for Linux VMs.
{
  pkgs,
  hostConfig,
  ...
}:
{
  imports = [
    ./base.nix
    ../shared/nvf
    ../nixos/i3.nix
    ../nixos/kitty.nix
    ../nixos/rofi.nix
  ];

  home.homeDirectory = "/home/${hostConfig.username}";
}
