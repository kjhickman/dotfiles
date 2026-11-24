{ config, lib, pkgs, ... }:

let
  dotnetup = pkgs.callPackage ../../pkgs/dotnetup.nix { };
  dotnetupDataDir = "${config.xdg.dataHome}/dotnetup";
in
{
  home.packages = [
    dotnetup
  ];

  home.sessionVariables = {
    DOTNET_DOTNETUP_DATA_DIR = dotnetupDataDir;
  } // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
    # .NET reads every file in these dirs, which is how it trusts the ASP.NET dev cert.
    SSL_CERT_DIR = "/etc/ssl/certs:/etc/pki/tls/certs:${config.home.homeDirectory}/.aspnet/dev-certs/trust";
    # OpenSSL tools like curl only find certs in a dir through hash links, which NixOS doesn't create, so give them the bundle file.
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
  };

  programs.fish.shellInit = ''
    ${dotnetup}/bin/dotnetup env script --shell fish --dotnet | source
  '';

  programs.zsh.envExtra = ''
    # .zshenv runs before Home Manager loads login-session variables.
    export DOTNET_DOTNETUP_DATA_DIR=${lib.escapeShellArg dotnetupDataDir}
    eval "$(${dotnetup}/bin/dotnetup env script --shell zsh --dotnet)"
  '';
}
