{ config, lib, pkgs, ... }:

let
  cfg = config.custom.firewall;
in {
  options.custom.firewall = {
    enable = lib.mkEnableOption "custom firewall rules";

    allowedTCPPorts = lib.mkOption {
      type = lib.types.listOf lib.types.port;
      default = [];
      description = "Additional TCP ports to allow through the firewall";
    };

    allowedUDPPorts = lib.mkOption {
      type = lib.types.listOf lib.types.port;
      default = [];
      description = "Additional UDP ports to allow through the firewall";
    };

    trustedInterfaces = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Network interfaces to trust (bypass firewall)";
    };

    enablePingBlock = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Block ICMP ping requests";
    };

    logRefusedConnections = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Log refused connections (useful for intrusion detection)";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = cfg.allowedTCPPorts;
      allowedUDPPorts = cfg.allowedUDPPorts;
      trustedInterfaces = cfg.trustedInterfaces;
      logRefusedConnections = cfg.logRefusedConnections;
      # Block pings if requested
      allowPing = !cfg.enablePingBlock;
      # Explicitly deny packets with bogus TCP flags
      extraCommands = ''
        # Drop INVALID packets
        iptables -A INPUT -m state --state INVALID -j DROP
        # Drop NULL packets
        iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
        # Drop XMAS packets
        iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
        # Drop SYN-FIN packets
        iptables -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP
        # Drop SYN-RST packets
        iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
      '';
      extraStopCommands = ''
        iptables -D INPUT -m state --state INVALID -j DROP 2>/dev/null || true
        iptables -D INPUT -p tcp --tcp-flags ALL NONE -j DROP 2>/dev/null || true
        iptables -D INPUT -p tcp --tcp-flags ALL ALL -j DROP 2>/dev/null || true
        iptables -D INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP 2>/dev/null || true
        iptables -D INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP 2>/dev/null || true
      '';
    };
  };
}
