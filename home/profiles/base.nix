# home/profiles/base.nix — shared defaults across all Home Manager profiles.
{
  pkgs,
  hostConfig,
  ...
}:
{
  imports = [
    ../shared/zsh.nix
    ../shared/starship.nix
    ../shared/zoxide.nix
    ../shared/atuin.nix
    ../shared/bat.nix
    ../shared/eza.nix
    ../shared/fzf.nix
    ../shared/git.nix
    ../shared/tmux.nix
  ];

  home.username = hostConfig.username;
  home.stateVersion = "25.11";

  home.packages = [
    pkgs.tree
  ];

  programs.yazi.enable = true;
  programs.home-manager.enable = true;
}
