{...}: {
  programs.nvf.settings.vim = {
    # Fuzzy finder
    telescope.enable = true;

    # Which-key for keybinding hints
    utility = {
      diffview-nvim.enable = true;
    };

    binds.whichKey.enable = true;

    # Git integration
    git = {
      enable = true;
      gitsigns.enable = true;
    };

    # File explorer
    filetree.neo-tree.enable = true;

    # Autopairs
    autopairs.nvim-autopairs.enable = true;

    # Autocompletion
    autocomplete.nvim-cmp.enable = true;

    # Comments
    comments.comment-nvim.enable = true;

    # Snippets
    snippets.luasnip.enable = true;

    # Terminal
    terminal.toggleterm = {
      enable = true;
      lazygit.enable = true;
    };

    # Mini plugins (like LazyVim uses)
    mini = {
      ai.enable = true; # Better text objects
      surround.enable = true; # Surround actions
    };
  };
}
