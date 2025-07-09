{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awscli2
    bat
    claude-code
    eza
    flyctl
    gitversion
    go
    go-task
    just
    neovim
    nodejs_24
    ripgrep
    rustup
    terraform
    zig
    zls

    nodePackages."@angular/cli"
  ];
}
