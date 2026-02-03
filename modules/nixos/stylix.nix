{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.custom.theme;
in {
  config = lib.mkIf cfg.enable {
    stylix.enable = true;
    stylix.polarity = "dark";

    stylix.targets.nvf.enable = false;

    # Theme-specific settings
    stylix.image = lib.mkMerge [
      (lib.mkIf (cfg.colorScheme == "nord") ../../wallpapers/nord-2.png)
      (lib.mkIf (cfg.colorScheme == "gruvbox") ../../wallpapers/gruvbox-3.png)
      (lib.mkIf (cfg.colorScheme == "tokyonight") ../../wallpapers/tokyonight-1.jpeg)
      (lib.mkIf (cfg.colorScheme == "rose-pine") ../../wallpapers/rose-pine-2.jpg)
      (lib.mkIf (cfg.colorScheme == "ayu") ../../wallpapers/ayu-5.jpg)
      (lib.mkIf (cfg.colorScheme == "kanagawa") ../../wallpapers/kanagawa-1.png)
    ];

    stylix.base16Scheme = lib.mkMerge [
      (lib.mkIf (cfg.colorScheme == "nord") "${pkgs.base16-schemes}/share/themes/nord.yaml")
      (lib.mkIf (cfg.colorScheme == "gruvbox") "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml")
      (lib.mkIf (cfg.colorScheme == "tokyonight") "${pkgs.base16-schemes}/share/themes/tokyo-night-moon.yaml")
      (lib.mkIf (cfg.colorScheme == "rose-pine") "${pkgs.base16-schemes}/share/themes/rose-pine.yaml")
      (lib.mkIf (cfg.colorScheme == "ayu") "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml")
      (lib.mkIf (cfg.colorScheme == "kanagawa") "${pkgs.base16-schemes}/share/themes/kanagawa.yaml")
    ];

    # Cursor theme based on selected theme
    stylix.cursor = lib.mkMerge [
      (lib.mkIf (cfg.colorScheme == "nord") {
        name = "Nordzy";
        package = pkgs.nordzy-cursor-theme;
        size = 32;
      })
      (lib.mkIf (cfg.colorScheme == "gruvbox") {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = 24;
      })
      (lib.mkIf (cfg.colorScheme == "rose-pine") {
        name = "BreezeX-RosePine-Linux";
        package = pkgs.rose-pine-cursor;
        size = 24;
      })
      (lib.mkIf (cfg.colorScheme == "ayu") {
        name = "BreezeX-RosePine-Linux";
        package = pkgs.rose-pine-cursor;
        size = 24;
      })
    ];

    # Fonts (shared across themes)
    stylix.fonts = {
      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        terminal = 12;
        applications = 11;
        desktop = 11;
      };
    };
  };
}
