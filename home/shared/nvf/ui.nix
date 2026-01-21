{ ... }:
{
  programs.nvf.settings.vim = {
    # Statusline (lualine) - let Stylix set the theme
    statusline.lualine.enable = true;

    # No bufferline/tabline (user disabled this in LazyVim)
    tabline.nvimBufferline.enable = false;

    # Dashboard
    dashboard.dashboard-nvim.enable = true;

    # UI enhancements
    ui = {
      noice.enable = true;
      borders.enable = true;
      colorizer.enable = true;
      illuminate.enable = true;
    };

    # Visuals
    visuals = {
      nvim-web-devicons.enable = true;
      indent-blankline.enable = true;
      nvim-cursorline.enable = true;
      fidget-nvim.enable = true;
    };
  };
}
