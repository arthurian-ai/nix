{ pkgs, ... }:
{
    stylix.enable = true;
    stylix.image = ../../wallpapers/gruvbox-1.jpg;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    stylix.polarity = "dark";

    # Fonts
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

    # Cursor theme (consolidated here - Stylix sets home.pointerCursor automatically)
    # stylix.cursor = {
    #     name = "Adwaita";
    #     package = pkgs.adwaita-icon-theme;
    #     size = 48;
    # };

    # Cursor environment variables for Wayland compatibility
    # environment.sessionVariables = {
    #     XCURSOR_THEME = "Adwaita";
    #     XCURSOR_SIZE = "48";
    # };
}
