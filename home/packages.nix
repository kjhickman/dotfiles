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
    neovim
    ripgrep
    rustup
    terraform
  ];
}
