{ config, pkgs, lib, ... }:

{
  # Sway configuration managed by home-manager
  # Colors handled by Stylix automatically

  wayland.windowManager.sway = {
    enable = true;

    config = rec {
      # Use Alt as modifier
      modifier = "Mod1";

      # Terminal
      terminal = "kitty";

      # Application launcher - rofi
      menu = "rofi -show drun";

      # Vim-style navigation keys
      left = "h";
      down = "j";
      up = "k";
      right = "l";

      # Keybindings
      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        # Applications
        "${mod}+Return" = "exec ${config.wayland.windowManager.sway.config.terminal}";
        "${mod}+space" = "exec ${config.wayland.windowManager.sway.config.menu}";
        "${mod}+Shift+q" = "kill";

        # Extra workspace bindings
        # "${mod}+t" = "workspace number 11";
        # "${mod}+b" = "workspace number 12";
        # "${mod}+o" = "workspace number 13";
        # "${mod}+Shift+t" = "move container to workspace number 11";
        # "${mod}+Shift+b" = "move container to workspace number 12";
        # "${mod}+Shift+o" = "move container to workspace number 13";

        # Screenshots
        "Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
        "Shift+Print" = "exec grim ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png";

        # Clipboard
        "${mod}+v" = "exec cliphist list | rofi -dmenu | cliphist decode | wl-copy";

        # Power menu
        "${mod}+Shift+e" = "exec wlogout";
      };

      # Startup applications
      startup = [
        { command = "waybar"; }
        { command = "swaymsg workspace 1"; }
        { command = "wl-paste --type text --watch cliphist store"; }
        { command = "wl-paste --type image --watch cliphist store"; }
        { command = "nm-applet --indicator"; }
      ];

      # Input configuration
      input = {
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
      };

      # Output configuration for VM
      output = {
        # "Virtual-1" = {
        #   mode = "3456x2168@60Hz";
        #   scale = "2";
        # };
        # Wallpaper handled by Stylix
      };

      # Colors handled by Stylix automatically

      # Window appearance
      window = {
        border = 2;
        titlebar = false;
      };

      floating = {
        border = 2;
        titlebar = false;
      };

      gaps = {
        inner = 8;
        outer = 4;
      };

      focus.followMouse = true;

      # Use waybar
      bars = [ ];
    };

    extraConfig = ''
      for_window [app_id="pavucontrol"] floating enable
      for_window [app_id="nm-connection-editor"] floating enable
      for_window [app_id="wlogout"] floating enable
      focus_wrapping no
      seat * xcursor_theme Adwaita 32
    '';
  };

  # Required packages for sway session
  home.packages = with pkgs; [
    # wl-clipboard
    # grim
    # slurp
    # cliphist
    # networkmanagerapplet
  ];
}
