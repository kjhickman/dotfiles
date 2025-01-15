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
    ripgrep
    rustup
    terraform
    zig
  ];
}
