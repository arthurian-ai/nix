# Home-Manager Steam Configuration
#
# User-level Steam settings, including:
#   - Desktop shortcuts
#   - Steam environment variables (for Proton, DXVK, etc.)
#   - Launch options
#
# Usage:
#   Add to your home-manager configuration in home/<profile>/default.nix:
#     imports = [
#       ../../home/nixos/steam.nix
#     ];
#
#   Or reference it directly:
#     home.activation.steam = lib.hm.dag.entryAfter ["writeBoundary"] ''
#       ${config.programs.steam.package}/bin/steam -shutdown
#     '';
#
# Configuration options (all optional):
#   home.steam = {
#     enable = true;
#     proton = {
#       enable = true;        # Add Proton environment variables
#       useDxvk = true;       # Use DXVK for DirectX->Vulkan translation
#       useVkd3d = true;       # Use vkd3d for DirectX12->Vulkan
#       esync = true;          # Enable esync for better performance
#       fsync = true;          # Enable fsync for better performance (Linux 5.0+)
#     };
#   };
#
{ lib, config, pkgs, ... }:

let
  cfg = config.home.steam;
in
{
  options.home.steam = {
    enable = lib.mkEnableOption "Steam user configuration";

    # Proton/Wine configuration via environment variables
    proton = {
      enable = lib.mkEnableOption "Proton environment variables";
      useDxvk = lib.mkEnableOption "DXVK (DirectX 11 to Vulkan)";
      useVkd3d = lib.mkEnableOption "vkd3d (DirectX 12 to Vulkan)";
      esync = lib.mkEnableOption "ESync for improved Wine performance";
      fsync = lib.mkEnableOption "FSync for improved Wine performance";
    };
  };

  config = lib.mkIf cfg.enable {
    # -------------------------------------------------------------------------
    # Steam Package (just enables the programs.steam module in HM)
    # -------------------------------------------------------------------------
    # Note: Steam is primarily configured at the NixOS level, but we can
    # add user-specific settings here
    programs.steam = {
      enable = true;
      # Remote play is configured at system level but can be enabled here too
      # remotePlay = true;
    };

    # -------------------------------------------------------------------------
    # Environment Variables for Proton/Wine
    # -------------------------------------------------------------------------
    # These environment variables optimize Wine/Proton performance for games.
    # They are automatically applied to all games running under Proton.
    home.sessionVariables = lib.mkIf cfg.proton.enable {
      # DXVK: Translate DirectX 11 calls to Vulkan
      # Significantly improves performance for many DirectX 11 games
      DXVK_ASYNC = "1";

      # vkd3d: Translate DirectX 12 to Vulkan
      # Enables DirectX 12 support in many games
      VKD3D_CONFIG = "upload_threads";

      # DXVK/NVAPI: Enable NVIDIA-specific optimizations
      # __GL_THREADED_OPTIMIZATION = "1";
      # RADV_PERFTEST = "gpl";

      # Wine Performance Tunables
      # ESync: Enables eventfd-based synchronization (better than futex)
      # Requires: ulimit -Hn (max files) >= 1048576
      WINEESYNC = lib.mkIf cfg.proton.esync "1";

      # FSync: Enables futex-based synchronization (Linux 5.0+)
      # Better than ESync but requires kernel support
      WINEFSYNC = lib.mkIf cfg.proton.fsync "1";

      # Game-specific fixes
      # Disable NVidia GPU timeout (reduces stuttering on NVIDIA)
      # DISABLE_NVVIDIA_TIMEOUT = "1";
    };

    # Additional session variables for better gaming experience
    home.sessionVariables = lib.mkIf cfg.enable {
      # SDL: Use Wayland when available
      SDL_VIDEODRIVER = "wayland,x11";

      # Electron: Disable GPU acceleration issues in some games
      # ELECTRON_DISABLE_GPU = "1";

      # Gamemode: Enable Feral Interactive's GameMode
      # Requires gamemode package installed on system
      # GAMEMODERUNEXEC = "${pkgs.gamemode}/bin/gamemoderun";

      # MangoHUD: Overlay for monitoring FPS, temps, etc.
      # Enable if you have mangohud installed
      # MANGOHUD = "1";
      # MANGOHUD_CONFIG = "fps,temp,position=top-right";
    };

    # -------------------------------------------------------------------------
    # Steam Desktop Integration
    # -------------------------------------------------------------------------
    # These settings add Steam-specific behavior to the desktop environment
    
    # XDG Desktop integration for Steam URLs
    xdg.mimeAssociations = {
      # Register steam:// protocol handler
      # This allows clicking steam:// links to open Steam
      schemes = ["steam"];
    };
  };
}
