{ config, lib, pkgs, inputs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "kyle";

  environment.systemPackages = [
    pkgs.wget # needed for VSCode remote
  ];

  # needed for VSCode remote
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  programs.fish.enable = true;
  users.users.kyle.shell = pkgs.fish;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05";
}
