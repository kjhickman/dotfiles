{ lib, stdenvNoCC, fetchurl }:

# Prebuilt binaries pinned in sources.json; run ./update.sh to move to the latest stable release.
let
  sources = lib.importJSON ./sources.json;
  source = sources.targets.${stdenvNoCC.hostPlatform.system}
    or (throw "browse: no build for ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  pname = "browse";
  inherit (sources) version;

  src = fetchurl { inherit (source) url sha256; };

  # Keep the vendor binary byte-identical (the macOS build is signed; the Linux one is static musl).
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 bin/browse $out/bin/browse
    runHook postInstall
  '';

  meta = {
    description = "MCP server and relay that let agents use your real browser";
    homepage = "https://github.com/anomalyco/browse";
    license = lib.licenses.mit;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = lib.attrNames sources.targets;
    mainProgram = "browse";
  };
}
