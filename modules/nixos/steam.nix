# Steam Gaming Module for NixOS
#
# This module provides a modular Steam configuration for gaming on NixOS.
# It handles:
#   - Steam installation and basic setup
#   - Steam Controller support (hardware.steam-hardware)
#   - GPU/vulkan configuration for gaming
#   - Firewall rules for Steam's networking features
#
# Usage:
#   Import this module in your host's default.nix:
#     imports = [
#       ../../modules/nixos/steam.nix
#     ];
#
#   And configure it (all options are optional):
#     custom.steam = {
#       enable = true;
#       remotePlay = true;       # Enable Steam Remote Play
#       firewall = true;         # Open firewall ports for Steam
#       steamController = true;  # Enable Steam Controller support
#     };
#
# For home-manager Steam settings ( Proton, desktop shortcuts, etc. ),
# also add home/nixos/steam.nix to your home-manager configuration.
#
{ lib, config, pkgs, ... }:

let
  cfg = config.custom.steam;
in
{
  options.custom.steam = {
    enable = lib.mkEnableOption "Steam and gaming support";

    # Enable Steam Remote Play (streaming games to other devices)
    remotePlay = lib.mkEnableOption "Steam Remote Play";

    # Open firewall ports for Steam networking (P2P, Remote Play)
    firewall = lib.mkEnableOption "Steam firewall rules";

    # Enable Steam Controller support via hardware.steam-hardware
    # This provides udev rules and kernel modules for Steam Controller
    steamController = lib.mkEnableOption "Steam Controller hardware support";

    # Enable Gamescope session support (for Steam Deck-like experience)
    gamescope = lib.mkEnableOption "Gamescope session support";

    # Enable proton for Windows game compatibility
    # Note: This just makes proton packages available; actual proton
    # selection happens inside Steam's settings
    enableProton = lib.mkEnableOption "Proton compatibility tool support";
  };

  config = lib.mkIf cfg.enable {
    # -------------------------------------------------------------------------
    # Core Steam Installation
    # -------------------------------------------------------------------------
    # The programs.steam module handles:
    #   - Steam package installation
    #   - Steam Boot (steamos-session) support
    #   - steam -enable-steamlink (for Steam Link device)
    programs.steam = {
      enable = true;
      # Enable Steam OS session type (for Steam Deck-like experience)
      # This provides steamos-session, steam.desktop, etc.
      remotePlay = cfg.remotePlay;
    };

    # -------------------------------------------------------------------------
    # Steam Controller Support
    # -------------------------------------------------------------------------
    # hardware.steam-hardware provides:
    #   - udev rules for Steam Controller, Steam Deck, etc.
    #   - Kernel modules needed for hardware access
    #   - bluetooth support for wireless controllers
    hardware.steam-hardware = lib.mkIf cfg.steamController {
      enable = true;
      # Enable external sensors support (for DIY Steam Controller projects)
      enableExternalSensors = false;
    };

    # -------------------------------------------------------------------------
    # Gamescope Session Support
    # -------------------------------------------------------------------------
    # Gamescope is a compositor specifically designed for gaming.
    # It provides:
    #   - Low-latency rendering
    #   - Freesync/VRR support
    #   - Upscaling (FSR)
    #   - Steam Deck-like session management
    # 
    # To use: Select "Steam" as session in SDDM/GDM, or launch gamescope-session
    services.steamos-control = lib.mkIf cfg.gamescope {
      enable = true;
      # Enable hardware video acceleration in gamescope
      hardwareVideoAccel = true;
    };

    # Also install gamescope package if enabled
    environment.systemPackages = lib.mkIf cfg.gamescope [
      pkgs.gamescope
    ];

    # -------------------------------------------------------------------------
    # Firewall Configuration for Steam
    # -------------------------------------------------------------------------
    # Steam requires these ports for:
    #   - 27031-27036: Steam content servers
    #   - 27015: Steam P2P networking (game sharing, remote play)
    #   - 3478, 3479, 3480: STUN/TURN for Remote Play
    networking.firewall = lib.mkIf cfg.firewall {
      allowedTCPPorts = [
        27031 # Steam client
        27036 # Steam API
        27015 # Steam P2P
        3478  # STUN for Remote Play
        3479  # TURN for Remote Play
      ];
      allowedUDPPorts = [
        27031 # Steam client
        27015 # Steam P2P
        3478  # STUN for Remote Play
        27017 # Steam matchmaking
      ];
    };

    # -------------------------------------------------------------------------
    # GPU / Vulkan Support for Gaming
    # -------------------------------------------------------------------------
    # These are typically configured elsewhere (in GPU modules), but we ensure
    # the basics are in place for gaming. Additional GPU config may be needed.
    #
    # For AMD GPUs (RADV): Should work out of the box with mesa
    # For NVIDIA GPUs: Ensure nvidia drivers are installed with vaapiSupport
    # For Intel GPUs: Ensure intel-media-driver is installed
    #
    # The steam module automatically enables:
    #   - vulkan-loader
    #   - vulkan-icd-loader (for finding GPU drivers)
    #   - 32-bit vulkan support (lib32-vulkan-loader)

    # -------------------------------------------------------------------------
    # Additional Gaming Packages
    # -------------------------------------------------------------------------
    # Proton GE (Glorious Eggroll) - Enhanced Proton build with more game fixes
    # This is available via nixpkgs but typically users install it through
    # Steam's compatibility tool management or via GE-Proton package
    environment.systemPackages = lib.mkIf cfg.enableProton [
      # protonup-qt allows installing Proton GE versions through a GUI
      pkgs.protonup-qt
    ];
  };
}
