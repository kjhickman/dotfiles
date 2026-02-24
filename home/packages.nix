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

    #dev
    bun
    deno
    go
    gh
    just
    nodejs_24
    rustup
    terraform
    typescript
    uv
    zig
    zls
    nodePackages."@angular/cli"

    # misc
    hledger
    hledger-ui
    hledger-web
    stockfish
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    xdg-utils
  ];
}
