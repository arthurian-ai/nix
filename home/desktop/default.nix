# Thin wrapper — delegates to the linux-workstation profile.
{ ... }:
{
  imports = [ ../profiles/linux-workstation.nix ];
}
