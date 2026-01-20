{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    # grim # screenshot functionality
    # slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    # mako # notification system developed by swaywm maintainer
    rofi
    waybar
  ];

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  # enable Sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland.enable = true;

    extraPackages = with pkgs; [
    	gnome-themes-extra # dark adwaita theme
    ];

    # VM compatibility - use software cursor rendering
    extraSessionCommands = ''
        export WLR_NO_HARDWARE_CURSORS=1
    '';
  };

  security.polkit.enable = true;
}
