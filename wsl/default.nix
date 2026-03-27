{ config, lib, pkgs, inputs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "kyle";

  environment.systemPackages = [
    pkgs.wget # needed for VSCode remote
    pkgs.docker
    pkgs.gcc
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  programs.fish.enable = true;
  users.users.kyle.shell = pkgs.fish;
  users.users.kyle.extraGroups = [ "docker" ];
  programs.fish.shellAbbrs = {
    nsw = "sudo nixos-rebuild switch --flake ~/repos/dotfiles#wsl";
  };

  # needed for VSCode remote
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    icu
    openssl
    zlib
    curl
    stdenv.cc.cc
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05";
}
