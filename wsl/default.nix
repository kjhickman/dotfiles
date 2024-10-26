{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      inputs.home-manager.nixosModules.default
    ];

  wsl.enable = true;
  wsl.defaultUser = "kyle";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    users = {
      "kyle" = import ./home.nix;
    };
  };

  system.stateVersion = "24.05";
}
