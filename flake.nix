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
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    superpowers = {
      url = "github:obra/superpowers";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      nix-homebrew,
      home-manager,
      hyprland,
      hyprland-plugins,
      stylix,
      nixos-hardware,
      noctalia,
      zen-browser,
      nvf,
      agenix,
      superpowers,
    }:
    let
      # ── Host inventory ──────────────────────────────────────────────
      rawHosts = import ./lib/hosts.nix;
      defaults = rawHosts._defaults;

      # Merge defaults into each host entry, drop the _defaults key
      hosts = nixpkgs.lib.mapAttrs
        (_: meta: defaults // meta)
        (builtins.removeAttrs rawHosts [ "_defaults" ]);

      # ── Partition by kind ───────────────────────────────────────────
      nixosHosts = nixpkgs.lib.filterAttrs (_: m: m.kind == "nixos") hosts;
      darwinHosts = nixpkgs.lib.filterAttrs (_: m: m.kind == "darwin") hosts;

      # ── Host module paths (must be literal for flake pure eval) ───
      hostModules = {
        desktop = ./hosts/desktop;
        thinkpad = ./hosts/thinkpad;
        kvm = ./hosts/kvm;
        parallels-vm = ./hosts/parallels-vm;
        mbp = ./hosts/mbp;
      };

      # ── Constructors ───────────────────────────────────────────────
      mkNixos = name: meta: import ./lib/mk-nixos-host.nix {
        inherit inputs self nixpkgs name meta;
        hostModule = hostModules.${name};
      };

      mkDarwin = name: meta: import ./lib/mk-darwin-host.nix {
        inherit inputs self nix-darwin name meta;
        hostModule = hostModules.${name};
      };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkNixos nixosHosts;
      darwinConfigurations = nixpkgs.lib.mapAttrs mkDarwin darwinHosts;
    };
}
