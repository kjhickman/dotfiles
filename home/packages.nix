{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awscli2
    bat
    eza
    go
    nodePackages.localtunnel
    neovim
    ripgrep
    rustup
    terraform
  ];
}
