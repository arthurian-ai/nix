{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.custom.stylix;
in {
  options.custom.stylix = {
    enable = lib.mkEnableOption "stylix theming";

    theme = lib.mkOption {
      type = lib.types.enum ["nord" "gruvbox" "tokyonight" "rose-pine"];
      default = "nord";
      description = "Color scheme theme to use";
    };
  };

  config = lib.mkIf cfg.enable {
    stylix.enable = true;
    stylix.polarity = "dark";

    stylix.targets.nvf.enable = false;

    # Theme-specific settings
    stylix.image = lib.mkMerge [
      (lib.mkIf (cfg.theme == "nord") ../../wallpapers/nord-2.png)
      (lib.mkIf (cfg.theme == "gruvbox") ../../wallpapers/gruvbox-1.jpg)
      (lib.mkIf (cfg.theme == "tokyonight") ../../wallpapers/tokyonight-1.jpeg)
      (lib.mkIf (cfg.theme == "rose-pine") ../../wallpapers/rose-pine-2.jpg)
    ];

    stylix.base16Scheme = lib.mkMerge [
      (lib.mkIf (cfg.theme == "nord") "${pkgs.base16-schemes}/share/themes/nord.yaml")
      (lib.mkIf (cfg.theme == "gruvbox") "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml")
      (lib.mkIf (cfg.theme == "tokyonight") "${pkgs.base16-schemes}/share/themes/tokyo-night-moon.yaml")
      (lib.mkIf (cfg.theme == "rose-pine") "${pkgs.base16-schemes}/share/themes/rose-pine.yaml")
    ];

    # Cursor theme based on selected theme
    stylix.cursor = lib.mkMerge [
      (lib.mkIf (cfg.theme == "nord") {
        name = "Nordzy";
        package = pkgs.nordzy-cursor-theme;
        size = 32;
      })
      (lib.mkIf (cfg.theme == "gruvbox") {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = 24;
      })
      (lib.mkIf (cfg.theme == "rose-pine") {
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
