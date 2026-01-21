{ ... }:
{
  programs.nvf.settings.vim = {
    options = {
      # Keep cursor centered
      scrolloff = 999;
      signcolumn = "yes";
      updatetime = 50;

      # Tabs and indentation
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;

      # No line wrapping
      wrap = false;

      # Split behavior
      splitbelow = true;
      splitright = true;

      # Visual block mode can go past end of line
      virtualedit = "block";

      # Preview find/replace in split
      inccommand = "split";

      # Case insensitive search
      ignorecase = true;
      smartcase = true;

      # Full color support
      termguicolors = true;

      # Line numbers
      number = true;
      relativenumber = true;
    };
  };
}
