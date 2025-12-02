{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # general
    bat
    coreutils
    eza
    neovim
    ripgrep

    # cloud
    awscli2

    #dev
    bun
    deno
    go
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
    claude-code
    github-copilot-cli
    gemini-cli
    ollama
    opencode
  ];
}
