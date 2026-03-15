{ config, lib, pkgs, ... }:

let
  cfg = config.custom.fail2ban;
in {
  options.custom.fail2ban = {
    enable = lib.mkEnableOption "fail2ban intrusion prevention";

    maxRetry = lib.mkOption {
      type = lib.types.int;
      default = 5;
      description = "Number of failures before banning an IP";
    };

    findTime = lib.mkOption {
      type = lib.types.str;
      default = "10m";
      description = "Time window in which failures are counted";
    };

    banTime = lib.mkOption {
      type = lib.types.str;
      default = "1h";
      description = "Duration of IP ban (use 'inf' for permanent bans)";
    };

    ignoreIPs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "127.0.0.1/8" "::1" ];
      description = "List of IPs/CIDR ranges to never ban";
    };

    enableSSHJail = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the SSH jail to protect the SSH daemon";
    };

    enableNginxJail = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable nginx jail (only useful if nginx is running)";
    };
  };

  config = lib.mkIf cfg.enable {
    services.fail2ban = {
      enable = true;
      maxretry = cfg.maxRetry;
      bantime = cfg.banTime;
      bantime-increment = {
        enable = true;
        factor = "2";
        maxtime = "48h";
        overalljails = true;
      };
      ignoreIP = cfg.ignoreIPs;

      jails = lib.mkMerge [
        (lib.mkIf cfg.enableSSHJail {
          sshd = {
            settings = {
              enabled = true;
              port = "ssh";
              filter = "sshd";
              maxretry = cfg.maxRetry;
              findtime = cfg.findTime;
              bantime = cfg.banTime;
            };
          };
        })
        (lib.mkIf cfg.enableNginxJail {
          nginx-http-auth = {
            settings = {
              enabled = true;
              port = "http,https";
              filter = "nginx-http-auth";
              maxretry = 5;
              findtime = "10m";
              bantime = "1h";
            };
          };
          nginx-nohome = {
            settings = {
              enabled = true;
              port = "http,https";
              filter = "nginx-nohome";
              maxretry = 2;
              findtime = "10m";
              bantime = "1h";
            };
          };
        })
      ];
    };

    # Ensure the firewall is enabled to allow fail2ban to work
    networking.firewall.enable = true;
  };
}
