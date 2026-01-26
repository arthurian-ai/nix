{...}: {
  programs.obsidian = {
    enable = true;
  };
  home.file = {
    "CJM/.obsidian.vimrc" = {
      source = ../../config/.obsidian.vimrc;
    };
  };
}
