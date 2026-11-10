{ lib, fetchurl, writeShellApplication, coreutils }:

let
  version = "0.3.0-preview.1.26554.3";
  src = fetchurl {
    url = "https://ci.dot.net/public/dotnetup/${version}/dotnetup-osx-arm64";
    hash = "sha256-f9gCLppg0voelYmGqh2YhdUnVAiaVckmnzqU5DIYGU0=";
  };
in
writeShellApplication {
  name = "dotnetup";
  derivationArgs = { inherit version; };
  runtimeInputs = [ coreutils ];

  text = ''
    if [[ "''${1-}" == self && "''${2-}" == update && "''${3-}" != --update-notifications ]]; then
      echo "dotnetup is managed by Nix; update pkgs/dotnetup.nix and rebuild instead." >&2
      exit 1
    fi

    # dotnetup requires a writable lock file beside its executable, even for
    # ordinary commands. Cache an unchanged copy to preserve Microsoft's signature.
    cache_dir="''${XDG_CACHE_HOME:-$HOME/.cache}/dotnetup/${builtins.baseNameOf src}"
    executable="$cache_dir/dotnetup"
    mkdir -p "$cache_dir"
    if ! cmp -s ${src} "$executable"; then
      temporary=$(mktemp "$cache_dir/.dotnetup.XXXXXXXX")
      trap 'rm -f "$temporary"' EXIT
      install -m755 ${src} "$temporary"
      mv -f "$temporary" "$executable"
    fi

    exec "$executable" "$@"
  '';

  meta = {
    description = "User-level .NET SDK and runtime manager";
    homepage = "https://learn.microsoft.com/en-us/dotnet/core/tools/dotnetup/";
    license = lib.licenses.mit;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "aarch64-darwin" ];
    mainProgram = "dotnetup";
  };
}
