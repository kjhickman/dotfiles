{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./ssh.nix
    ./dotnet.nix
  ];

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}

