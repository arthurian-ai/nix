# home/profiles/darwin.nix — HM profile for macOS (nix-darwin).
{
  pkgs,
  hostConfig,
  ...
}:
{
  imports = [
    ./base.nix
    ../shared/ghostty.nix
    ../shared/codex.nix
    ../shared/claude-code.nix
  ];

  home.homeDirectory = hostConfig.homeDirectory or "/Users/${hostConfig.username}";

  # Darwin uses a slightly older stateVersion
  home.stateVersion = "25.05";

  home.file = {
    ".config/yabai/yabairc".source = ../../config/yabairc;
    ".config/skhd/skhdrc".source = ../../config/skhdrc;
  };
}
