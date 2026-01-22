{lib, ...}: {
  programs.nvf.settings.vim = {
    # Statusline (lualine)
    statusline.lualine.enable = true;
    statusline.lualine.theme = lib.mkForce "auto";

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
      indent-blankline.enable = false;
      nvim-cursorline.enable = true;
      fidget-nvim.enable = true;
    };
    theme.name = lib.mkForce "rose-pine";
    theme.style = lib.mkForce "main";
  };
}
