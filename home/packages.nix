{ pkgs, ... }:

{
  home.packages = with pkgs; [
    eza
    ripgrep
    terraform
  ];
}
