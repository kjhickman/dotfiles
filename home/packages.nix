{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awscli2
    eza
    neovim
    ripgrep
    terraform
  ];
}
