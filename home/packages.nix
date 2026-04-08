{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # general
    bat
    coreutils
    eza
    difftastic
    neovim
    prmt
    ripgrep
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
    rustup
    terraform
    typescript
    uv
    zig
    zls
    # misc
    hledger
    hledger-ui
    hledger-web
    stockfish
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    xdg-utils
  ];
}
