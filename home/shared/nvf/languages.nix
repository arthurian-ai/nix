{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    # Enable LSP
    lsp = {
      enable = true;
      formatOnSave = true;
      trouble.enable = true;
      lightbulb.enable = true;
    };

    # Enable treesitter
    treesitter = {
      enable = true;
      highlight.enable = true;
      indent.enable = true;
    };

    # Language support - nvf handles LSP, treesitter, formatting automatically
    languages = {
      enableLSP = true;
      enableFormat = true;
      enableTreesitter = true;

      nix.enable = true;
      python.enable = true;
      clang.enable = true;
      lua.enable = true;
      markdown.enable = true;
      bash.enable = true;
      ts.enable = true;
      html.enable = true;
      css.enable = true;
      yaml.enable = true;
    };

    # LaTeX support via vimtex
    extraPlugins = {
      vimtex = {
        package = pkgs.vimPlugins.vimtex;
        setup = ''
          vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
          vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
          vim.g.vimtex_compiler_latexmk = {
            options = {
              "-verbose",
              "-file-line-error",
              "-synctex=1",
              "-interaction=nonstopmode",
              "-shell-escape",
            },
          }
        '';
      };
    };
  };
}
