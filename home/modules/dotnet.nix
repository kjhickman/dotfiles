{ config, lib, pkgs, isDarwin, ... }:

let
  dotnetup = pkgs.callPackage ../../pkgs/dotnetup.nix { };
  dotnetupDataDir = "${config.xdg.dataHome}/dotnetup";
  dotnetCombined = pkgs.dotnetCorePackages.combinePackages (with pkgs.dotnetCorePackages; [
    sdk_8_0-bin
    sdk_9_0-bin
    sdk_10_0-bin
    sdk_11_0-bin
  ]);
in
{
  home.packages = [
    (if isDarwin then dotnetup else dotnetCombined)
  ];

  home.sessionVariables = {
    SSL_CERT_DIR = "/etc/ssl/certs:/etc/pki/tls/certs:${config.home.homeDirectory}/.aspnet/dev-certs/trust";
  } // lib.optionalAttrs isDarwin {
    DOTNET_DOTNETUP_DATA_DIR = dotnetupDataDir;
  } // lib.optionalAttrs (!isDarwin) {
    DOTNET_ROOT = "${dotnetCombined}/share/dotnet";
    DOTNET_ROOT_X64 = "${dotnetCombined}/share/dotnet";
  };

  programs.fish.shellInit = lib.mkIf isDarwin ''
    ${dotnetup}/bin/dotnetup env script --shell fish --dotnet | source
  '';

  programs.zsh.envExtra = lib.mkIf isDarwin ''
    # .zshenv runs before Home Manager loads login-session variables.
    export DOTNET_DOTNETUP_DATA_DIR=${lib.escapeShellArg dotnetupDataDir}
    eval "$(${dotnetup}/bin/dotnetup env script --shell zsh --dotnet)"
  '';
}
