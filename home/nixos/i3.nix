{
  config,
  pkgs,
  lib,
  ...
}: let
  mod = "Mod1"; # Alt key
in {
  # home.sessionVariables = {
  #   GDK_SCALE = "2";
  #   GDK_DPI_SCALE = "0.5";
  #   QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  # };

  home.sessionVariables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    QT_AUTO_SCREEN_SCALE_FACTOR = "0"; # Disable auto-detect
    QT_SCALE_FACTOR = "2"; # Explicit 2x for Qt
    QT_FONT_DPI = "96"; # Prevent double-scaling text
    ELECTRON_OZONE_PLATFORM_HINT = "x11"; # Keep Electron on X11
  };

  xresources.properties = {
    "Xft.dpi" = 192;
  };

  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = mod;
      terminal = "kitty";
      menu = "rofi -show drun";

      # Keybindings
      keybindings = lib.mkOptionDefault {
        # Applications
        "${mod}+Return" = "exec kitty";
        "${mod}+space" = "exec rofi -show drun";
        "${mod}+q" = "kill";

        # Focus (vim keys)
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move windows (vim keys)
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # Extra workspaces
        "${mod}+t" = "workspace number 11";
        "${mod}+b" = "workspace number 12";
        "${mod}+o" = "workspace number 13";
        "${mod}+Shift+t" = "move container to workspace number 11";
        "${mod}+Shift+b" = "move container to workspace number 12";
        "${mod}+Shift+o" = "move container to workspace number 13";

        # Screenshots
        "Print" = "exec maim -s | xclip -selection clipboard -t image/png";
        "Shift+Print" = "exec maim ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png";

        # Layout
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+a" = "focus parent";

        # Scratchpad
        "${mod}+Shift+minus" = "move scratchpad";
        "${mod}+minus" = "scratchpad show";

        # Reload/restart
        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+e" = "exec i3-nagbar -t warning -m 'Exit i3?' -B 'Yes' 'i3-msg exit'";

        # Resize mode
        "${mod}+r" = "mode resize";
      };

      modes = {
        resize = {
          "h" = "resize shrink width 10 px";
          "j" = "resize grow height 10 px";
          "k" = "resize shrink height 10 px";
          "l" = "resize grow width 10 px";
          "Left" = "resize shrink width 10 px";
          "Down" = "resize grow height 10 px";
          "Up" = "resize shrink height 10 px";
          "Right" = "resize grow width 10 px";
          "Return" = "mode default";
          "Escape" = "mode default";
        };
      };

      # Window settings
      window = {
        border = 2;
        titlebar = false;
      };

      floating = {
        border = 2;
        titlebar = false;
        criteria = [
          {class = "Pavucontrol";}
          {class = "Nm-connection-editor";}
          {class = "feh";}
        ];
      };

      gaps = {
        inner = 6;
        outer = 3;
      };

      focus.followMouse = true;

      bars = [];
      # Use i3bar with i3status (or configure polybar separately)
      # bars = [{
      #   position = "bottom";
      #   statusCommand = "${pkgs.i3status}/bin/i3status";
      # }];
      #
      # Startup applications
      startup = [
        {
          command = "xrandr --output Virtual-1 --mode 2880x1800 --dpi 192";
          notification = false;
        }
        {
          command = "feh --bg-fill ../../wallpapers/gruvbox-1.jpg";
          notification = false;
        }
        {
          command = "xset r rate 300 50";
          notification = false;
        }
        {
          command = "spice-vdagent";
          notification = false;
        }
        {
          command = "nm-applet";
          notification = false;
        }
        {
          command = "dunst";
          notification = false;
        }
        # Compositor for smooth rendering
        {
          command = "picom -b";
          notification = false;
        }
      ];
    };
  };

  # i3status config
  # programs.i3status = {
  #   enable = false;
  #   general = {
  #     colors = true;
  #     interval = 5;
  #   };
  #   modules = {
  #     "disk /" = {
  #       position = 1;
  #       settings.format = "/ %avail";
  #     };
  #     "memory" = {
  #       position = 2;
  #       settings.format = "MEM %percentage_used";
  #     };
  #     "cpu_usage" = {
  #       position = 3;
  #       settings.format = "CPU %usage";
  #     };
  #     "tztime local" = {
  #       position = 4;
  #       settings.format = "%Y-%m-%d %H:%M";
  #     };
  #   };
  # };
  #
  # Required packages
  home.packages = with pkgs; [
    xclip
    maim
    feh
    picom
  ];
}
