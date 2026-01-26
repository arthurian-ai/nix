{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # required dependencies
    git
    # TODO: add check for if this system is running wayland
    emacs-pgtk
    ripgrep
    # optional dependencies
    coreutils # basic GNU utilities
    fd
    clang

    # Shell
    shellcheck
    shfmt

    # Python
    black
    isort
    python3Packages.pyflakes
    python3Packages.pytest

    # Go (if using Go)
    gopls
    gomodifytags
    gotests
    gore

    # C/C++/Java
    clang-tools # includes clang-format
    jdk

    # Other
    nixfmt-rfc-style # or nixfmt-classic
    libxml2 # includes xmllint
    pandoc # for markdown preview
  ];

  services.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk; # replace with emacs-gtk, or a version provided by the community overlay if desired.
  };
}
# git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
# ~/.emacs.d/bin/doom install

