# hosts/mbp/default.nix — MacBook Pro, delegates to darwin base.
{
  self,
  inputs,
  pkgs,
  hostConfig,
  ...
}:
{
  imports = [
    ../../modules/darwin/base.nix
  ];

  # ── Home Manager ──────────────────────────────────────────────────
  home-manager.users.${hostConfig.username} = import ../../home/darwin;
}
