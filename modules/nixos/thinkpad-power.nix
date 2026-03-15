{ config, lib, pkgs, ... }:

let
  cfg = config.custom.thinkpadPower;
in {
  options.custom.thinkpadPower = {
    enable = lib.mkEnableOption "ThinkPad power management optimizations";

    tlpEnable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable TLP power management daemon";
    };

    powerProfiles = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use power-profiles-daemon instead of TLP (mutually exclusive with TLP)";
    };

    acpiCallEnable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable acpi_call kernel module for ThinkPad battery management";
    };

    batteryChargeStartThreshold = lib.mkOption {
      type = lib.types.int;
      default = 75;
      description = "Battery charge start threshold (percent) for TLP";
    };

    batteryChargeStopThreshold = lib.mkOption {
      type = lib.types.int;
      default = 80;
      description = "Battery charge stop threshold (percent) for TLP";
    };

    lidSuspend = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Suspend on lid close";
    };

    lidSuspendExternalPower = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Suspend on lid close even when on external power";
    };

    enableFirmwareUpdates = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable fwupd for firmware updates including ThinkPad UEFI/EC";
    };
  };

  config = lib.mkIf cfg.enable {
    # Intel microcode and redistributable firmware (covers ThinkPad WiFi/Bluetooth)
    hardware.enableRedistributableFirmware = true;
    hardware.enableAllFirmware = true;

    # acpi_call for battery charge thresholds on ThinkPad
    boot.extraModulePackages = lib.mkIf cfg.acpiCallEnable
      [ config.boot.kernelPackages.acpi_call ];

    # TLP power management
    services.tlp = lib.mkIf (cfg.tlpEnable && !cfg.powerProfiles) {
      enable = true;
      settings = {
        # CPU scaling governor
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        # CPU energy/performance policy (Intel HWP)
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        # Battery charge thresholds (ThinkPad-specific via acpi_call / thinkpad_acpi)
        START_CHARGE_THRESH_BAT0 = cfg.batteryChargeStartThreshold;
        STOP_CHARGE_THRESH_BAT0 = cfg.batteryChargeStopThreshold;

        # Runtime PM for PCIe devices
        RUNTIME_PM_ON_AC = "auto";
        RUNTIME_PM_ON_BAT = "auto";

        # WiFi power saving
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";

        # PCIe ASPM
        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersupersave";

        # NMI watchdog - disable to save power on battery
        NMI_WATCHDOG = 0;

        # Disable Wake-on-LAN on battery
        WOL_DISABLE = "Y";
      };
    };

    # power-profiles-daemon (alternative to TLP)
    services.power-profiles-daemon.enable = cfg.powerProfiles;

    # thermald for Intel thermal management
    services.thermald.enable = true;

    # Lid close behavior
    services.logind = lib.mkIf cfg.lidSuspend {
      lidSwitch = "suspend";
      lidSwitchExternalPower = if cfg.lidSuspendExternalPower then "suspend" else "ignore";
      lidSwitchDocked = "ignore";
      extraConfig = ''
        HoldoffTimeoutSec=2s
      '';
    };

    # fwupd for firmware updates (ThinkPad BIOS/EC updates via LVFS)
    services.fwupd.enable = cfg.enableFirmwareUpdates;

    # Needed for fwupd to apply EFI capsule updates
    security.tpm2.enable = true;

    # upower for battery status reporting
    services.upower.enable = true;
  };
}
