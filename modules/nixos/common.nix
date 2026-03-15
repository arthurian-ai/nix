{ config, lib, pkgs, hostConfig, ... }:

# Common NixOS configuration shared across all physical and virtual machines.
# This module consolidates repeated patterns from individual host configurations:
# locale/timezone settings, networking, pipewire audio, user account setup,
# nix flake settings, and zsh default shell.
{
  # Nix flakes and command support
  nix.settings.experimental-features = "nix-command flakes";

  # Allow unfree packages (needed for things like zoom, slack, chrome)
  nixpkgs.config.allowUnfree = true;

  # Locale and timezone (driven by per-host hostConfig)
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

  # Default shell: zsh
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Networking: NetworkManager (suitable for both laptops and desktops)
  networking = {
    hostName = hostConfig.hostname;
    networkmanager.enable = true;
  };

  # Pipewire audio (replaces PulseAudio)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Firefox (declarative program management)
  programs.firefox.enable = true;

  # Essential system packages available on all hosts
  environment.systemPackages = with pkgs; [
    git
    tmux
  ];

  # Primary user account
  users.users.${hostConfig.username} = {
    isNormalUser = true;
    description = hostConfig.username;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = [];
  };
}
