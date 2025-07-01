{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awscli2
    bat
    gitversion
    eza
    flyctl
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
