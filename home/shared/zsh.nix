{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      cat = "bat";
      ls = "eza";
      grep = "rg";
      fzf = ''fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'';
      clear = "command clear && fastfetch";
    };

    initContent = ''
      bindkey -v
      export PATH="/Library/TeX/texbin:$PATH"
      export PATH="$HOME/.emacs.d/bin:$PATH"
      cd() {
        z "$@"
        eza -l
      }
      fastfetch
    '';
  };
}
