{ config, lib, pkgs, inputs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "kyle";

  environment.systemPackages = [
    pkgs.wget # needed for VSCode remote
    pkgs.docker
    pkgs.gcc
  ];

  programs.fish.enable = true;
  programs.fish.shellAbbrs = {
    nsw = "sudo nixos-rebuild switch --flake ~/repos/dotfiles#wsl";
  };

  # needed for VSCode remote
  programs.nix-ld.enable = true;

  users.users.kyle.shell = pkgs.fish;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05";
}
