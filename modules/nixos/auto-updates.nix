{ config, lib, pkgs, ... }:

let
  cfg = config.custom.autoUpdates;
in {
  options.custom.autoUpdates = {
    enable = lib.mkEnableOption "automatic NixOS updates";

    dates = lib.mkOption {
      type = lib.types.str;
      default = "04:00";
      description = "When to run automatic updates (systemd calendar format)";
    };

    allowReboot = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to allow automatic reboots after updates";
    };

    rebootWindow = lib.mkOption {
      type = lib.types.nullOr (lib.types.submodule {
        options = {
          lower = lib.mkOption { type = lib.types.str; default = "01:00"; };
          upper = lib.mkOption { type = lib.types.str; default = "05:00"; };
        };
      });
      default = null;
      description = "Time window in which automatic reboots are allowed";
    };

    flake = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "github:owner/nix-config#hostname";
      description = "Flake URI to update from. If null, uses the system flake.";
    };

    gcEnable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable automatic garbage collection of old generations";
    };

    gcDates = lib.mkOption {
      type = lib.types.str;
      default = "weekly";
      description = "When to run garbage collection (systemd calendar format)";
    };

    gcMaxAge = lib.mkOption {
      type = lib.types.str;
      default = "30d";
      description = "Maximum age for generations to keep during GC";
    };
  };

  config = lib.mkIf cfg.enable {
    # Automatic updates via nixos-rebuild
    system.autoUpgrade = {
      enable = true;
      dates = cfg.dates;
      allowReboot = cfg.allowReboot;
    } // lib.optionalAttrs (cfg.flake != null) {
      flake = cfg.flake;
    } // lib.optionalAttrs (cfg.rebootWindow != null) {
      rebootWindow = cfg.rebootWindow;
    };

    # Automatic garbage collection
    nix.gc = lib.mkIf cfg.gcEnable {
      automatic = true;
      dates = cfg.gcDates;
      options = "--delete-older-than ${cfg.gcMaxAge}";
    };

    # Optimize the nix store after each build to save space
    nix.settings.auto-optimise-store = true;
  };
}
