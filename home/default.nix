{ config, pkgs, lib, ... }:

let
  moduleDir = ./modules;
  moduleImports = builtins.map
    (name: moduleDir + "/${name}")
    (builtins.attrNames (lib.filterAttrs
      (name: type: (type == "regular" || type == "symlink")
        && lib.hasSuffix ".nix" name)
      (builtins.readDir moduleDir)));
in
{
  imports = [
    ./packages.nix
  ] ++ moduleImports;

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
