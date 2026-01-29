{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    openvpn
    nmap
    netcat
    tcpdump
    inetutils
    samba
    burpsuite
    redis
    freerdp
    gobuster
    dnsenum
    onesixtyone
    net-snmp
    openssl
    mariadb
    nfs-utils
  ];
}
