{ pkgs, ... }:

{
  home.packages = with pkgs; [
    eza
    neovim
    ripgrep
    terraform
  ];
}
