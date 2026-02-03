{
  config,
  lib,
  ...
}: let
  cfg = config.custom.theme;
in {
  options.custom.theme = {
    enable = lib.mkEnableOption "custom theming";

    colorScheme = lib.mkOption {
      type = lib.types.enum ["nord" "gruvbox" "tokyonight" "rose-pine" "ayu" "kanagawa" "gruvbox"];
      default = "nord";
      description = "Color scheme to use";
    };

    transparency = lib.mkEnableOption "transparency and blur effects";
  };
}
