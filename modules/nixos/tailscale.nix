{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.tailscale = {
    enable = true;
    extraUpFlags = [ "--shields-up" ];
    useRoutingFeatures = "client";
  };
}
