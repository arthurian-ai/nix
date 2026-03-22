# mk-nixos-host.nix — build a nixosSystem from host metadata.
#
# Arguments:
#   inputs      — the full flake inputs attrset
#   self        — the flake's self reference
#   nixpkgs     — the nixpkgs input
#   name        — host attribute name (e.g. "desktop")
#   meta        — host metadata from lib/hosts.nix (already merged with defaults)
#   hostModule  — the module path for this host (e.g. ../hosts/desktop)
{
  inputs,
  self,
  nixpkgs,
  name,
  meta,
  hostModule,
}:

nixpkgs.lib.nixosSystem {
  system = meta.system;
  modules = [ hostModule ];
  specialArgs = {
    inherit self inputs;
    hostConfig = meta;
  };
}
