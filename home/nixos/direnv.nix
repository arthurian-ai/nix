{...}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # better nix integration, caches builds
  };
}
