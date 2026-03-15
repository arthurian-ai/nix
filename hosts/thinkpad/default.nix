# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  hostConfig,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-13th-gen
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    inputs.agenix.nixosModules.default
    ../../modules/nixos/networking.nix
    ../../modules/nixos/theme.nix
    ../../modules/nixos/stylix.nix
    ../../modules/nixos/noctalia.nix
    ../../modules/nixos/packages.nix
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/keyd.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/thunar.nix
    ../../modules/nixos/regreet.nix
    ../../modules/nixos/virtualization.nix
    ../../modules/nixos/tailscale.nix
    ../../modules/nixos/thinkpad-power.nix
    ../../modules/nixos/ssh-hardening.nix
    ../../modules/nixos/firewall.nix
    ../../modules/nixos/fail2ban.nix
    ../../modules/nixos/auto-update.nix
    ../../modules/shared/emacs.nix
  ];

  # Keyd configuration for ThinkPad
  custom.keyd = {
    enable = true;
    enableThinkpadMeta = true;
  };

  # Theme settings for ThinkPad
  custom.theme = {
    enable = true;
    colorScheme = "tokyonight";
    transparency = true;
  };

  # ThinkPad power management and firmware
  custom.thinkpadPower = {
    enable = true;
    tlpEnable = true;
    acpiCallEnable = true;
    batteryChargeStartThreshold = 75;
    batteryChargeStopThreshold = 80;
    lidSuspend = true;
    lidSuspendExternalPower = true;
    enableFirmwareUpdates = true;
  };

  # SSH hardening
  custom.sshHardening = {
    enable = true;
    allowPasswordAuth = false;
    allowRootLogin = "no";
  };

  # Firewall rules
  custom.firewall = {
    enable = true;
    logRefusedConnections = true;
  };

  # fail2ban intrusion prevention
  custom.fail2ban = {
    enable = true;
    enableSSHJail = true;
    maxRetry = 5;
    banTime = "1h";
  };

  # Automatic nix store garbage collection (updates managed manually for ThinkPad)
  custom.autoUpdate = {
    enable = true;
    gcEnable = true;
    gcDates = "weekly";
    gcMaxAge = "30d";
  };

  # For noctalia shell
  hardware.bluetooth.enable = true;
  services.tuned.enable = true;

  # Fingerprint reader
  services.fprintd.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs hostConfig; };
    users.${hostConfig.username} = import ../../home/laptop;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  nix.settings = {
    experimental-features = "nix-command flakes";

    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  # Enable zsh and set as default shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel for best ThinkPad X1 Gen 13 hardware support.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Disable Intel PSR (Panel Self Refresh) to fix screen stretching/corruption crashes.
  # The xe driver's PSR implementation has known bugs on Intel Arc/Xe hardware.
  # Uncomment if you experience screen flickering or corruption:
  # boot.kernelParams = [ "xe.enable_psr=0" ];

  # Intel graphics: enable hardware acceleration and GuC/HuC firmware loading
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver  # VAAPI for Intel Arc/Xe (iHD driver)
      intel-compute-runtime  # OpenCL support
    ];
  };

  networking.hostName = hostConfig.hostname;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # or -wlr for wlroots compositors
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users.${hostConfig.username} = {
    isNormalUser = true;
    description = hostConfig.username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "video"
    ];
    packages = with pkgs; [ ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    git
    tmux
    # neovim - provided by nvf in home-manager
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
