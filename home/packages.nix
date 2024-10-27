{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awscli2
    eza
    go
    neovim
    ripgrep
    rustup
    terraform
  ];
}
