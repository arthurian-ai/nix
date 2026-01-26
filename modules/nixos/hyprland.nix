{ inputs, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # nvidiaPatches = true;

    # withUWSM = true;

    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

    environment.sessionVariables = {
        # Hint electron apps to use wayland
        NIXOS_OZONE_WL = "1";
        # If your cursor becomes invisible
        WLR_NO_HARDWARE_CURSORS = "1";
    };

    # hardware = {
    #     opengl.enable = true;
    #     # Most wayland compositors need this
    #     nvidia.modesetting.enable = true;
    # };

    environment.systemPackages = with pkgs; [
        # waybar
        # dunst
        # libnotify
        # rofi
        # swww
        # hyprpolkitagent #should be in HM?
        # wl-clipboard
        # xdg-desktop-portal-hyprland
        # kdePackages.dolphin

        # pkgs.eww
  
    # pyprland
    # hyprpicker
    # hyprcursor
    # hyprlock
    # hypridle
    # hyprpaper
    # hyprsunset
    # hyprpolkitagent
    ];

    security.polkit.enable = true;

    # PAM service for hyprlock (enables fingerprint auth)
    security.pam.services.hyprlock = {};

    # xdg.portal = {
    #         enable = true;
    #         # extraProtals = [ pkgs.xdg-desktop-portal-hyprland ];
    # };

    # services.displayManager.sddm = {
    #     enable = true;
    #     wayland.enable = true;
    # };

    # Enable sound with pipewire
    # sound.enable = true;
    # security.rtkit.enable = true;
    # services.pipewire = {
    #     enable = true;
    #     alsa.enable = true;
    #     alsa.support32Bit = true;
    #     pulse.enable = true;
    #     jack.enable = true;
    # };
    #

    services.pipewire = {
        enable = true;
    };
}
