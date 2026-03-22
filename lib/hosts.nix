# Host inventory — single source of truth for all active systems.
# Each entry captures the metadata needed by mk-nixos-host.nix / mk-darwin-host.nix.
{
  # ── Common defaults (merged into every host) ──────────────────────
  _defaults = {
    timezone = "America/Los_Angeles";
    locale = "en_US.UTF-8";
  };

  # ── NixOS hosts ───────────────────────────────────────────────────
  desktop = {
    kind = "nixos";
    system = "x86_64-linux";
    username = "curtis";
    hostname = "nixos-desktop";
    role = "workstation";
    monitors = [ ", preferred, auto, 1" ];
    isLaptop = false;
    hasNvidia = true;
  };

  thinkpad = {
    kind = "nixos";
    system = "x86_64-linux";
    username = "curtis";
    hostname = "nixos";
    role = "workstation";
    monitors = [ "eDP-1, 2880x1800@120, auto, 2" ];
    isLaptop = true;
    hasNvidia = false;
  };

  kvm = {
    kind = "nixos";
    system = "x86_64-linux";
    username = "citrus";
    hostname = "nixos";
    role = "vm";
  };

  parallels-vm = {
    kind = "nixos";
    system = "aarch64-linux";
    username = "citrus";
    hostname = "nixos";
    role = "vm";
  };

  # ── Darwin hosts ──────────────────────────────────────────────────
  mbp = {
    kind = "darwin";
    system = "aarch64-darwin";
    username = "curtis";
    hostname = "mbp";
    role = "darwin";
    homeDirectory = "/Users/curtis";
  };
}
