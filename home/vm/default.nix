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
    # ../shared/ghostty.nix
    ../shared/tmux.nix
    # ../shared/neovim.nix
    ../shared/nvf
    # ../shared/java.nix
    ../nixos/i3.nix
    # ../nixos/sway.nix
    ../nixos/kitty.nix
    # ../nixos/alacritty.nix
    ../nixos/rofi.nix
    # ../nixos/waybar.nix
  ];

  home.username = hostConfig.username;
  home.homeDirectory = "/home/${hostConfig.username}";
  home.stateVersion = "25.11";

  # # Cursor configuration for Wayland/Sway
  # home.pointerCursor = {
  #     gtk.enable = true;
  #     package = pkgs.adwaita-icon-theme;
  #     name = "Adwaita";
  #     size = 24;
  # };

  home.packages = [
    pkgs.tree
  ];

  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  home.file = {
  };

  programs.yazi.enable = true;

  programs.home-manager.enable = true;
}
