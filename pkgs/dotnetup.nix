{ lib, stdenv, fetchurl, writeShellApplication, autoPatchelfHook, coreutils, openssl }:

let
  version = "0.3.0-preview.1.26554.3";
  assets = {
    aarch64-darwin = {
      name = "dotnetup-osx-arm64";
      hash = "sha256-f9gCLppg0voelYmGqh2YhdUnVAiaVckmnzqU5DIYGU0=";
    };
    x86_64-linux = {
      name = "dotnetup-linux-x64";
      hash = "sha256-VGqhfD/in3EaF8/XvjoN46Xj6/SXC4WuxN1j4o7vHE4=";
    };
  };
  asset = assets.${stdenv.hostPlatform.system}
    or (throw "dotnetup: no build for ${stdenv.hostPlatform.system}");

  download = fetchurl {
    url = "https://ci.dot.net/public/dotnetup/${version}/${asset.name}";
    inherit (asset) hash;
  };

  # The Linux build needs its loader rewritten for NixOS, plus a runpath entry for
  # the libssl it dlopens when downloading SDKs.
  patched = stdenv.mkDerivation {
    pname = "dotnetup-unwrapped";
    inherit version;
    dontUnpack = true;
    nativeBuildInputs = [ autoPatchelfHook ];
    appendRunpaths = [ "${lib.getLib openssl}/lib" ];
    installPhase = ''
      install -Dm755 ${download} $out/bin/dotnetup
    '';
  };

  src = if stdenv.hostPlatform.isDarwin then "${download}" else "${patched}/bin/dotnetup";
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
    # ordinary commands. Cache a byte-identical copy rather than rewriting the
    # executable in place, which would break Microsoft's signature on macOS.
    cache_dir="''${XDG_CACHE_HOME:-$HOME/.cache}/dotnetup/${builtins.baseNameOf download}"
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
    platforms = lib.attrNames assets;
    mainProgram = "dotnetup";
  };
}
