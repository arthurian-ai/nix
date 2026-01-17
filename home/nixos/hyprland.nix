{ pkgs, ... }:
{
    imports = [
        # ./dunst.nix
        # ./kitty.nix
        # ./rofi.nix
        # ./waybar.nix
    ];

    home.packages = with pkgs; [
        # Hyprland utilities
        # hyprpaper          # Wallpaper daemon
        # hyprlock           # Screen locker
        # hypridle           # Idle daemon
        # # Status bar and widgets
        # waybar
        # # App launcher
        # rofi       # or wofi
        # # Notifications
        # dunst              # or mako
        # # Terminal (pick one)
        # kitty
        # # alacritty
        # # File manager
        # # thunar
        # # Screenshot tools
        # grim
        # slurp
        # swappy
        # # Other useful tools
        # wl-clipboard       # Clipboard manager
        # cliphist           # Clipboard history
        # pavucontrol        # Audio control
        # brightnessctl      # Brightness control
        # networkmanagerapplet
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
				natural_scroll = false;
			};
		};

		bind = [
			"$mod, Return, exec, $terminal"
			"$mod, B, exec, $browser"
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
		];
	};
    };


}
