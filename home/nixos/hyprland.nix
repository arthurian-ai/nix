{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  transparency = osConfig.custom.theme.transparency or false;
in {
  imports = [
    ./swappy.nix
    ./hypridle.nix
    ./hyprlock.nix
  ];

  home.packages = with pkgs; [
    grim
    slurp

    wl-clipboard
    cliphist
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "$SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$browser" = "zen";

      exec-once = [
        "noctalia-shell"
        # "wl-paste --type text --watch cliphist store"
        # "wl-paste --type image --watch cliphist store"
      ];

      input = {
        follow_mouse = 1;
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        scroll_factor = 0.8;

        repeat_rate = 50;
        repeat_delay = 300;

        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true;
        };
      };

      device = {
        name = "tpps/2-elan-trackpoint";
        accel_profile = "flat";
        sensitivity = -0.2;
      };

      monitor = [
        # "eDP-1, 2880x1800@120, auto, 1.8"
        "eDP-1, 2880x1800@120, auto, 2"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
      };

      decoration = {
        rounding = 6;
        rounding_power = 3;

        active_opacity = if transparency then 0.8 else 1.0;
        inactive_opacity = if transparency then 0.8 else 1.0;
        fullscreen_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 20;
          render_power = 2;
          offset = "0 5";
          color = lib.mkDefault "rgba(00000055)";
        };

        blur = {
          enabled = transparency;
          size = 15;
          passes = 3;
          noise = 0.08;
          contrast = 2;
          brightness = 1.0;
          vibrancy = 0.5;
          new_optimizations = true;
          popups = true;
        };
      };

      # Layer rules for noctalia shell blur
      layerrule = [
        "blur on, match:namespace r:^noctalia.*$"
      ];

      # Make certain windows fully opaque
      windowrulev2 = [
        "opacity 1.0 override, class:^(firefox)$"
        "opacity 1.0 override, class:^(zen)$"
        "opacity 1.0 override, class:^(mpv)$"
        "opacity 1.0 override, fullscreen:1"
      ];

      animations = {
        enabled = false;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2; # always split to the right/bottom
      };

      bind = [
        "$mod, Return, exec, $terminal"
        # "$mod, B, exec, $browser"
        "$mod, Q, killactive,"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod, T, workspace, 11"
        "$mod, B, workspace, 12"
        "$mod, A, workspace, 13"
        "$mod, D, workspace, 14"
        "$mod, C, workspace, 15"
        "$mod, S, workspace, 15"
        "$mod, O, workspace, 16"
        "$mod, V, workspace, 17"
        "$mod, E, workspace, 18"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod SHIFT, T, movetoworkspace, 11"
        "$mod SHIFT, B, movetoworkspace, 12"
        "$mod SHIFT, A, movetoworkspace, 13"
        "$mod SHIFT, D, movetoworkspace, 14"
        "$mod SHIFT, C, movetoworkspace, 15"
        "$mod SHIFT, S, movetoworkspace, 15"
        "$mod SHIFT, O, movetoworkspace, 16"
        "$mod SHIFT, V, movetoworkspace, 17"
        "$mod SHIFT, E, movetoworkspace, 18"

        # Focus movement (vim keys + arrows)
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Move windows (vim keys)
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, j, movewindow, d"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, l, movewindow, r"

        # Window management
        "$mod, F, fullscreen, 0"
        "$mod SHIFT, F, togglefloating,"
        # "$mod, E, togglesplit,"
        # "$mod, P, pseudo,"

        "$mod, SPACE, exec, noctalia-shell ipc call launcher toggle"
        # "$mod, S, exec, noctalia-shell ipc call controlCenter toggle"
        # "$mod, comma, exec, noctalia-shell ipc call settings toggle"
        "$mod, X, exec, noctalia-shell ipc call launcher clipboard"
        # "$mod, L, exec, noctalia-shell ipc call lockScreen lock"

        # Screenshots with swappy
        ", Print, exec, grim -g \"$(slurp)\" - | swappy -f - ; noctalia-shell ipc call toast send '{\"title\": \"Screenshot\", \"body\": \"Region captured\", \"icon\": \"camera\", \"duration\": 1000}'"
        "SHIFT, Print, exec, grim - | swappy -f - ; noctalia-shell ipc call toast send '{\"title\": \"Screenshot\", \"body\": \"Screen captured\", \"icon\": \"camera\", \"duration\": 1000}'"

        # Lock screen
        "CTRL SHIFT $mod, L, exec, loginctl lock-session"

        # App launchers ($mod + alt + key)
        "$mod ALT, t, exec, $terminal"
        "$mod ALT, b, exec, $browser"
        "$mod ALT, o, exec, obsidian"
        "$mod ALT, e, exec, $fileManager"
        "$mod ALT, v, exec, virt-manager"
        "$mod ALT, d, exec, vesktop"
      ];

      # Allow on lock screen
      bindl = [
        ", XF86AudioMute, exec, noctalia-shell ipc call volume muteOutput"
        ", switch:Lid Switch, exec, systemctl suspend"
      ];

      # Resize windows (repeatable)
      binde = [
        "$mod CTRL, h, resizeactive, -30 0"
        "$mod CTRL, j, resizeactive, 0 30"
        "$mod CTRL, k, resizeactive, 0 -30"
        "$mod CTRL, l, resizeactive, 30 0"
      ];

      # Allow on lock screen and repeat
      bindel = [
        ", XF86AudioRaiseVolume, exec, noctalia-shell ipc call volume increase"
        ", XF86AudioLowerVolume, exec, noctalia-shell ipc call volume decrease"
        ", XF86MonBrightnessUp, exec, noctalia-shell ipc call brightness increase"
        ", XF86MonBrightnessDown, exec, noctalia-shell ipc call brightness decrease"
      ];
    };

    extraConfig = ''
      layerrule {
      	name = noctalia
      	match:namespace = noctalia-background-.*$
      	ignore_alpha = 0.5
      	blur = true
      	blur_popups = true
      }
    '';
  };

  services.hyprpolkitagent.enable = true;
}
