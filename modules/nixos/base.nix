# modules/nixos/base.nix — common Linux system foundation.
# Shared by all NixOS hosts (workstations and VMs alike).
{
  pkgs,
  hostConfig,
  ...
}:
{
  # ── Shell ──────────────────────────────────────────────────────────
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # ── Networking ─────────────────────────────────────────────────────
  networking.hostName = hostConfig.hostname;
  networking.networkmanager.enable = true;

  # ── Locale & timezone ─────────────────────────────────────────────
  time.timeZone = hostConfig.timezone;
  i18n.defaultLocale = hostConfig.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = hostConfig.locale;
    LC_IDENTIFICATION = hostConfig.locale;
    LC_MEASUREMENT = hostConfig.locale;
    LC_MONETARY = hostConfig.locale;
    LC_NAME = hostConfig.locale;
    LC_NUMERIC = hostConfig.locale;
    LC_PAPER = hostConfig.locale;
    LC_TELEPHONE = hostConfig.locale;
    LC_TIME = hostConfig.locale;
  };

  # ── User ───────────────────────────────────────────────────────────
  users.users.${hostConfig.username} = {
    isNormalUser = true;
    description = hostConfig.username;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # ── Nix ────────────────────────────────────────────────────────────
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  # ── Audio (pipewire) ──────────────────────────────────────────────
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ── Base packages ─────────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    git
    tmux
  ];

  programs.firefox.enable = true;
}
