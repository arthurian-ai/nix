# overlays/default.nix — NixOS module that applies the flake's overlays.
# This keeps backward compatibility with hosts that `import ../../overlays`.
{ self, ... }:
{
  nixpkgs.overlays = [ self.overlays.default ];
}
