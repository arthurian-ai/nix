{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
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
    bat
    tldr
    btop
    rust-analyzer
    yt-dlp
    cmake
    gcc
    claude-code
    opencode
    keyd
    fastfetch
    google-chrome
    openssl

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    protonvpn-gui
    darktable
    zoom-us
    slack
  ];
}
