{ config, pkgs, ... }:

{
  imports = [
    ./dotnet.nix
    ./git.nix
    ./packages.nix
    ./ssh.nix
    ./zsh.nix
  ];

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}

