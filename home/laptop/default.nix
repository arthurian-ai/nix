{
  pkgs,
  hostConfig,
  ...
}: {
  imports = [
    ../shared/zsh.nix
    ../shared/starship.nix
    ../shared/zoxide.nix
    ../shared/atuin.nix
    ../shared/bat.nix
    ../shared/eza.nix
    ../shared/fzf.nix
    ../shared/git.nix
    ../shared/nvf
    ../shared/tmux.nix
    ../nixos/hyprland.nix
    ../nixos/kitty.nix
    ../nixos/noctalia.nix
    ../nixos/zathura.nix
    ../nixos/obsidian.nix
    ../nixos/vesktop.nix
  ];

  home.username = hostConfig.username;
  home.homeDirectory = "/home/${hostConfig.username}";
  home.stateVersion = "25.11";

  home.packages = [
    # pkgs.git
    pkgs.tree
  ];

  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  home.file = {
    # ".config/nvim" = {
    #     source = ../../config/nvim;
    #     recursive = true;
    # };
  };

  programs.yazi.enable = true;

  programs.home-manager.enable = true;
}
