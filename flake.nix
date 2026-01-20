{
    description = "Configuration for NixOS and MacOS";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nix-homebrew.url = "github:zhaofengli/nix-homebrew";
        hyprland.url = "github:hyprwm/Hyprland";
	nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-darwin = {
            url = "github:nix-darwin/nix-darwin/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprland-plugins = {
            url = "github:hyprwm/hyprland-plugins";
            inputs.hyprland.follows = "hyprland";
        };
        stylix = {
            url = "github:nix-community/stylix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	noctalia = {
		url = "github:noctalia-dev/noctalia-shell";
		inputs.nixpkgs.follows = "nixpkgs";
	};
	zen-browser = {
		url = "github:youwen5/zen-browser-flake";
		inputs.nixpkgs.follows = "nixpkgs";
	};
    };

    outputs = inputs@{self, nixpkgs, nix-darwin, nix-homebrew, home-manager, hyprland, hyprland-plugins, stylix, nixos-hardware, noctalia, zen-browser}:
        let
            # Common settings
            commonConfig = {
                timezone = "America/Los_Angeles";
                locale = "en_US.UTF-8";
            };

            # Per-host settings
            vmConfig = commonConfig // {
                username = "citrus";
                hostname = "nixos";
            };

            thinkpadConfig = commonConfig // {
                username = "curtis";
                hostname = "nixos";
            };

            desktopConfig = commonConfig // {
                username = "curtis";
                hostname = "nixos-desktop";
            };

            mbpConfig = commonConfig // {
                username = "curtis";
                hostname = "mbp";
            };
        in
        {
            nixosConfigurations = {
                parallels-vm = nixpkgs.lib.nixosSystem {
                    system = "aarch64-linux";
                    modules = [ ./hosts/parallels-vm ];
                    specialArgs = { inherit self inputs; hostConfig = vmConfig; };
                };
                utm-vm = nixpkgs.lib.nixosSystem {
                    system = "aarch64-linux";
                    modules = [ ./hosts/utm-vm ];
                    specialArgs = { inherit self inputs; hostConfig = vmConfig; };
                };
                kvm = nixpkgs.lib.nixosSystem {
                    system = "x86_64-linux";
                    modules = [ ./hosts/kvm ];
                    specialArgs = { inherit self inputs; hostConfig = vmConfig; };
                };
                desktop = nixpkgs.lib.nixosSystem {
                    system = "x86_64-linux";
                    modules = [ ./hosts/desktop ];
                    specialArgs = { inherit self inputs; hostConfig = desktopConfig; };
                };
                thinkpad = nixpkgs.lib.nixosSystem {
                    system = "x86_64-linux";
                    modules = [ ./hosts/thinkpad ];
                    specialArgs = { inherit self inputs; hostConfig = thinkpadConfig; };
                };
            };

            darwinConfigurations = {
                mbp = nix-darwin.lib.darwinSystem {
                    system = "aarch64-darwin";
                    modules = [ ./hosts/mbp ];
                    specialArgs = { inherit self inputs; hostConfig = mbpConfig; };
                };
            };
        };
}
