{ inputs, ... }:
{
  imports = [
    inputs.nvf.homeManagerModules.default
    ./options.nix
    ./keymaps.nix
    ./languages.nix
    ./ui.nix
    ./editor.nix
  ];

  programs.nvf = {
    enable = true;
    defaultEditor = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        # Let Stylix handle theming
        # theme.enable = false;
      };
    };
  };
}
