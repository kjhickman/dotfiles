{ config, lib, pkgs, inputs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "kyle";

  programs.zsh.enable = true;
  users.users.kyle.shell = pkgs.zsh;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05";
}
