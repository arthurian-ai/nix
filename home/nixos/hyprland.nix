{ pkgs, lib, ... }:
{
    imports = [
        ./swappy.nix
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
		"$browser" = "firefox";

		exec-once = [
			"noctalia-shell"
		];

		input = {
			touchpad = {
				natural_scroll = true;
				clickfinger_behavior = true;
			};
		};

		monitor = [
			"eDP-1, 2880x1800@120, auto, 2"
		];

		general = {
			gaps_in = 5;
			gaps_out = 10;
			border_size = 2;
		};

		decoration = {
			rounding = 20;
			rounding_power = 2;

			active_opacity = 0.9;
			inactive_opacity = 0.9;
			fullscreen_opacity = 1.0;

			shadow = {
				enabled = true;
				range = 4;
				render_power = 3;
				color = lib.mkDefault "rgba(1a1a1aee)";
			};

			blur = {
				enabled = true;
				size = 3;
				passes = 2;
				vibrancy = 0.1696;
			};
		};

		animations = {
			enabled = false;
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

			"$mod, SPACE, exec, noctalia-shell ipc call launcher toggle"
			# "$mod, S, exec, noctalia-shell ipc call controlCenter toggle"
			# "$mod, comma, exec, noctalia-shell ipc call settings toggle"
			"$mod, X, exec, noctalia-shell ipc call launcher clipboard"
			# "$mod, L, exec, noctalia-shell ipc call lockScreen lock"

			# Screenshots with swappy
			", Print, exec, grim -g \"$(slurp)\" - | swappy -f - ; noctalia-shell ipc call toast send '{\"title\": \"Screenshot\", \"body\": \"Region captured\", \"icon\": \"camera\", \"duration\": 1000}'"
			"SHIFT, Print, exec, grim - | swappy -f - ; noctalia-shell ipc call toast send '{\"title\": \"Screenshot\", \"body\": \"Screen captured\", \"icon\": \"camera\", \"duration\": 1000}'"
		];

		# Allow on lock screen
		bindl = [
			", XF86AudioMute, exec, noctalia-shell ipc call volume muteOutput"
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
