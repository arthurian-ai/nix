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
		exec-once = [
			"qs -c noctalia-shell"
		];
	};
    };


}
