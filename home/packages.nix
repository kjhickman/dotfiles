{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # general
    bat
    coreutils
    eza
    neovim
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
    stockfish
  ];
}
