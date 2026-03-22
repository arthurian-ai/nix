# hosts/kvm/default.nix — KVM VM with i3, hardware + overrides.
{
  config,
  pkgs,
  inputs,
  hostConfig,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/profiles/vm.nix
    ../../modules/nixos/i3.nix
    ../../overlays
  ];

  environment.etc.hosts.mode = "0644";

  # ── Keyd (remap super for VM) ─────────────────────────────────────
  custom.keyd = {
    enable = true;
    remapSuperKey = true;
  };

  # ── Theme ──────────────────────────────────────────────────────────
  custom.theme = {
    enable = true;
    colorScheme = "gruvbox";
    transparency = false;
  };

  # ── Home Manager ──────────────────────────────────────────────────
  home-manager.users.${hostConfig.username} = import ../../home/vm;

  # ── KVM guest services ────────────────────────────────────────────
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  # ── Boot ──────────────────────────────────────────────────────────
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # ── X11 + GDM (i3 via X11 works better in this VM) ───────────────
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # ── Extra packages ───────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    spice-vdagent
  ];
}
