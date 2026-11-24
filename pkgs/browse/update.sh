#!/usr/bin/env -S nix shell nixpkgs#curl nixpkgs#jq --command bash
# Pins browse to the current stable release by rewriting sources.json from Anomaly's release manifest.
set -euo pipefail
cd "$(dirname "$0")"

origin=https://anoma.ly
curl -fsSL "$origin/release/browse/cli/stable.json" | jq --arg origin "$origin" '
  if .app != "browse" or .artifact != "cli" or .channel != "stable" then error("not the browse stable CLI manifest") end
  | .release as $release
  | {
      version: $release.version,
      targets: {
        "x86_64-linux": $release.targets["linux-x64-musl"],
        "aarch64-darwin": $release.targets["macos-arm64"]
      }
      | map_values(if . == null then error("missing target") end | { url: ($origin + .url), sha256 })
    }' > sources.json.tmp
mv sources.json.tmp sources.json
echo "browse $(jq -r .version sources.json)"
