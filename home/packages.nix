{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # general
    bat
    coreutils
    eza
    difftastic
    neovim
    nixd
    prmt
    ripgrep
    sqlite
    tldr
    msedit

    # cloud
    awscli2
    flyctl

    #dev
    bun
    deno
    go
    gh
    just
    nodejs_24
    ollama
    playwright
    powershell
    rustup
    selene
    stylua
    # terraform
    typescript
    uv
    zig
    zls
    # misc
    hledger
    hledger-ui
    hledger-web
    fastchess
    stockfish
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    xdg-utils
  ];
}
