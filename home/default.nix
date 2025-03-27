{ config, pkgs, ... }:

{
  imports = [
    ./dotnet.nix
    ./fish.nix
    ./git.nix
    ./packages.nix
    ./ssh.nix
    ./starship.nix
    ./warp.nix
    ./zsh.nix
  ];

  programs.zoxide.enable = true;

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}

