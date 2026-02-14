{ isDarwin, pkgs, lib, ... }:

let
  dotnetCombined = pkgs.dotnetCorePackages.combinePackages (with pkgs.dotnetCorePackages; [
    sdk_8_0
    sdk_9_0
    sdk_10_0
  ]);
in
# Due do annoying MacOS issues, only install .NET this way on Linux systems
lib.mkIf (!isDarwin) {
  home.packages = [
    dotnetCombined
  ];

  home.sessionVariables = {
    DOTNET_ROOT = "${dotnetCombined}/share/dotnet";
    DOTNET_ROOT_X64 = "${dotnetCombined}/share/dotnet";
  };
}
