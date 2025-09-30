{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # general
    bat
    eza
    neovim
    ripgrep

    # cloud
    awscli2
    flyctl

    #dev
    bun
    deno
    go
    just
    nodejs_24
    rustup
    terraform
    typescript
    zig
    zls
    nodePackages."@angular/cli"

    # llm
    claude-code
    ollama
  ];
}
