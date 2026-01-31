{ config, pkgs, lib, ... }:

{
  # Due do annoying MacOS issues, only install .NET this way on Linux systems
  home.packages = lib.optionals pkgs.stdenv.hostPlatform.isLinux [
    (pkgs.dotnetCorePackages.combinePackages (with pkgs.dotnetCorePackages; [
      sdk_8_0
      sdk_9_0
      sdk_10_0
    ]))
  ];
}
