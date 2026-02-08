{ isDarwin, pkgs, lib, ... }:

# Due do annoying MacOS issues, only install .NET this way on Linux systems
lib.mkIf (!isDarwin) {
  home.packages = [
    (pkgs.dotnetCorePackages.combinePackages (with pkgs.dotnetCorePackages; [
      sdk_8_0
      sdk_9_0
      sdk_10_0
    ]))
  ];
}
