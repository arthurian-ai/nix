{ config, lib, pkgs, ... }:

let
  cfg = config.custom.ssh;
in {
  options.custom.ssh = {
    enable = lib.mkEnableOption "SSH hardening";

    allowPasswordAuth = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Allow password authentication (disabled by default for security)";
    };

    allowRootLogin = lib.mkOption {
      type = lib.types.enum [ "yes" "no" "prohibit-password" "forced-commands-only" ];
      default = "no";
      description = "Whether to allow root login";
    };

    listenPort = lib.mkOption {
      type = lib.types.port;
      default = 22;
      description = "Port for SSH daemon to listen on";
    };

    authorizedKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of authorized SSH public keys for the primary user";
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [ cfg.listenPort ];
      settings = {
        PasswordAuthentication = cfg.allowPasswordAuth;
        PermitRootLogin = cfg.allowRootLogin;
        # Disable X11 forwarding
        X11Forwarding = false;
        # Use only strong ciphers and MACs
        Ciphers = [
          "chacha20-poly1305@openssh.com"
          "aes256-gcm@openssh.com"
          "aes128-gcm@openssh.com"
          "aes256-ctr"
          "aes192-ctr"
          "aes128-ctr"
        ];
        Macs = [
          "hmac-sha2-512-etm@openssh.com"
          "hmac-sha2-256-etm@openssh.com"
          "umac-128-etm@openssh.com"
        ];
        KexAlgorithms = [
          "curve25519-sha256"
          "curve25519-sha256@libssh.org"
          "diffie-hellman-group16-sha512"
          "diffie-hellman-group18-sha512"
        ];
        # Limit login attempts
        MaxAuthTries = 3;
        # Enable strict mode
        StrictModes = true;
        # Disable empty passwords
        PermitEmptyPasswords = false;
        # Disconnect idle sessions after 5 minutes
        ClientAliveInterval = 300;
        ClientAliveCountMax = 2;
        # Disable TCP forwarding by default
        AllowTcpForwarding = false;
        # Disable agent forwarding by default
        AllowAgentForwarding = false;
        # Limit login grace time
        LoginGraceTime = 30;
      };
    };

    # Open the SSH port in the firewall
    networking.firewall.allowedTCPPorts = [ cfg.listenPort ];
  };
}
