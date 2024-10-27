{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awscli2
    bat
    eza
    go
    neovim
    ripgrep
    rustup
    terraform
  ];
}
