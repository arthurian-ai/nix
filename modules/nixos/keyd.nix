{ config, lib, ... }:

let
  cfg = config.custom.keyd;
in
{
  options.custom.keyd = {
    enable = lib.mkEnableOption "keyd key remapping";

    remapSuperKey = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Remap super to Ctrl+Alt+Shift+Super (useful for VMs where host captures super)";
    };

    enableThinkpadMeta = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ThinkPad-specific meta layer mapping";
    };

    capsToCtrlEsc = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Map capslock to ctrl when held, esc when tapped";
    };
  };

  config = lib.mkIf cfg.enable {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        settings = {
          main = lib.mkMerge [
            # Capslock to ctrl/esc (default on)
            (lib.mkIf cfg.capsToCtrlEsc {
              capslock = "overload(control, esc)";
            })

            # ThinkPad meta layer
            (lib.mkIf cfg.enableThinkpadMeta {
              "leftshift+leftmeta+f23" = "layer(meta)";
            })

            # Remap super to Ctrl+Alt+Shift+Super for VMs
            (lib.mkIf cfg.remapSuperKey {
              leftmeta = "C-A-S-leftmeta";
              rightmeta = "C-A-S-rightmeta";
            })
          ];
        };
      };
    };
  };
}
