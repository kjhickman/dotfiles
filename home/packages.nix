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
    edit

    # cloud
    awscli2

    #dev
    bun
    deno
    go
    gh
    hugo
    just
    nodejs_24
    ollama
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
