{ config, pkgs, lib, ... }:
{
  # Enable X11 and i3
  services.xserver = {
    enable = true;
    dpi = 192;
    windowManager.i3.enable = true;
    videoDrivers = [ "virtio" ];
  };

  # Display manager
  services.displayManager.defaultSession = "none+i3";

  environment.systemPackages = with pkgs; [
    rofi           # application launcher
    dunst          # notifications
    libnotify      # notification library
    feh            # wallpaper setter
    picom          # compositor for transparency
    xclip          # clipboard
    maim           # screenshots
    xdotool        # window automation
    arandr         # display configuration GUI
    lxappearance   # GTK theme settings
    pavucontrol    # audio control
    networkmanagerapplet
  ];

  # Enable gnome-keyring for secrets
  services.gnome.gnome-keyring.enable = true;

  security.polkit.enable = true;
}
