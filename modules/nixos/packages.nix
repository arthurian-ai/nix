{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    neovim
    ripgrep
    fd
    go
    python3
    ruff
    nil
    cargo
    rustc
    docker
    docker-compose
    colima
    stow
    uv
    vscode
    bat
    tldr
    btop
    rust-analyzer
    yt-dlp
    cmake
    # google-chrome
    gcc
    # kitty
    # claude
    claude-code
    # ghostty
    # alacritty
    keyd
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    protonvpn-gui
    obsidian
    fastfetch
  ];
}
