{ config, pkgs, ... }:

{
  imports = [
    ./dotnet.nix
    ./git.nix
    ./ssh.nix
  ];

  home.username = "kyle";
  home.homeDirectory = "/home/kyle";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [];

  home.file = {
    # Add any file management configurations here
  };

  home.sessionVariables = {
    # Add environment variable
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
