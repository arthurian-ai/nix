# mk-darwin-host.nix — build a darwinSystem from host metadata.
#
# Arguments:
#   inputs      — the full flake inputs attrset
#   self        — the flake's self reference
#   nix-darwin  — the nix-darwin input
#   name        — host attribute name (e.g. "mbp")
#   meta        — host metadata from lib/hosts.nix (already merged with defaults)
#   hostModule  — the module path for this host (e.g. ../hosts/mbp)
{
  inputs,
  self,
  nix-darwin,
  name,
  meta,
  hostModule,
}:

nix-darwin.lib.darwinSystem {
  system = meta.system;
  modules = [ hostModule ];
  specialArgs = {
    inherit self inputs;
    hostConfig = meta;
  };
}
