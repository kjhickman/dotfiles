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
    rustup
    terraform
    typescript
    uv
    zig
    zls
    nodePackages."@angular/cli"

    # llm
    codex
    ollama

    # misc
    stockfish
  ];
}
