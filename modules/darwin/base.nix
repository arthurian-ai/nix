# modules/darwin/base.nix — common Darwin foundation.
{
  self,
  inputs,
  hostConfig,
  ...
}:
{
  imports = [
    ./system.nix
    ./packages.nix
    ./homebrew.nix
    ./fonts.nix
    ./services.nix
    ./tailscale.nix
    ./stylix.nix
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.stylix.darwinModules.stylix
  ];

  users.users.${hostConfig.username} = {
    name = hostConfig.username;
    home = hostConfig.homeDirectory or "/Users/${hostConfig.username}";
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs hostConfig; };
    useGlobalPkgs = true;
  };

  system = {
    primaryUser = hostConfig.username;
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;
  };

  nixpkgs = {
    hostPlatform = hostConfig.system;
    config.allowUnfree = true;
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = hostConfig.username;
  };

  nix.enable = false;
  nix.settings.experimental-features = "nix-command flakes";
}
