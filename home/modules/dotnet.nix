{ config, pkgs, ... }:

let
  dotnetCombined = pkgs.dotnetCorePackages.combinePackages (with pkgs.dotnetCorePackages; [
    sdk_8_0-bin
    sdk_9_0-bin
    sdk_10_0-bin
    sdk_11_0-bin
  ]);
in
{
  home.packages = [
    dotnetCombined
  ];

  home.sessionVariables = {
    DOTNET_ROOT = "${dotnetCombined}/share/dotnet";
    DOTNET_ROOT_X64 = "${dotnetCombined}/share/dotnet";
    SSL_CERT_DIR = "/etc/ssl/certs:/etc/pki/tls/certs:${config.home.homeDirectory}/.aspnet/dev-certs/trust";
  };
}
