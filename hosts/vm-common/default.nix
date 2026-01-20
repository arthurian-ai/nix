# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, hostConfig, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
        inputs.home-manager.nixosModules.home-manager
	inputs.stylix.nixosModules.stylix
	../../modules/nixos/packages.nix
	# ../../modules/nixos/security-packages.nix
	../../modules/nixos/i3.nix  # Use i3 instead of sway (X11 works better in Parallels)
	# ../../modules/nixos/sway.nix
	# ../../modules/nixos/hyprland.nix
	../../modules/nixos/keyd.nix
	../../modules/nixos/fonts.nix
	../../modules/nixos/stylix.nix
    ];

    # Keyd configuration for VM - disable super key
    custom.keyd = {
      enable = true;
      disableSuperKey = true;
    };

    # Stylix theme for VM
    custom.stylix = {
      enable = true;
      theme = "gruvbox";
    };

   home-manager = {
        extraSpecialArgs = { inherit inputs hostConfig; };
        users.${hostConfig.username} = import ../../home/vm;  # VM-specific home config
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
    };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = hostConfig.hostname;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
	users.defaultUserShell = pkgs.zsh;
	programs.zsh.enable = true;

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

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" "video" "render" ];
    packages = with pkgs; [];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    tmux
    neovim
    mesa-demos  # for glxinfo debugging
  ];

nix.settings.experimental-features = "nix-command flakes";

# hardware.parallels.enable = true;
# hardware.graphics.enable = true;

# hardware.graphics = {
#   enable = true;
  # extraPackages = with pkgs; [
  #   mesa
  # ];
# };

# Force software rendering for VM compatibility
# environment.sessionVariables = {
#   LIBGL_ALWAYS_SOFTWARE = "1";
#   WLR_RENDERER_ALLOW_SOFTWARE = "1";
# };

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

