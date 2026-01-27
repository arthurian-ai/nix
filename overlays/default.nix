{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      dnsenum = prev.dnsenum.overrideAttrs (old: {
        buildInputs = (old.buildInputs or []) ++ [prev.makeWrapper];
        postFixup = let
          perlEnv = prev.perl.withPackages (ps:
            with ps; [
              RegexpIPv6
              NetIP
              NetDNS
              NetNetmask
              XMLWriter
              StringRandom
              NetWhoisIP
              WWWMechanize
            ]);
        in ''
          sed -i "1s|.*|#!${perlEnv}/bin/perl|" $out/bin/dnsenum
        '';
      });
    })
  ];
}
