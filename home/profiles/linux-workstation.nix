# home/profiles/linux-workstation.nix — HM profile for physical Linux workstations.
{
  pkgs,
  hostConfig,
  ...
}:
{
  imports = [
    ./base.nix
    ../shared/nvf
    ../shared/opencode.nix
    ../shared/codex.nix
    ../shared/claude-code.nix
    ../nixos/hyprland.nix
    ../nixos/kitty.nix
    ../nixos/noctalia.nix
    ../nixos/zathura.nix
    ../nixos/obsidian.nix
    ../nixos/vesktop.nix
    ../nixos/qutebrowser.nix
    ../nixos/direnv.nix
  ];

  home.homeDirectory = "/home/${hostConfig.username}";
}
