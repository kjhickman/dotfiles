{ aiAgentsInstructions, config, lib, pkgs, ... }:

let
  settingsFile = "${config.home.homeDirectory}/.pi/agent/settings.json";
  managedSettingsFile = pkgs.writeText "pi-settings.json" (builtins.toJSON {
    defaultTools = [
      "read"
      "bash"
      "edit"
      "write"
      "grep"
      "find"
      "ls"
    ];
    packages = [
      "npm:@juicesharp/rpiv-todo@2.9.0"
      "npm:@juicesharp/rpiv-ask-user-question@2.9.0"
      "npm:pi-subagents@0.64.0"
      "npm:pi-web-access@0.27.0"
    ];
    quietStartup = true;
    theme = "dark";
  });
  updateSettings = pkgs.writeShellScript "update-pi-settings" ''
    set -euo pipefail

    settings_file=$1
    settings_dir="$(dirname "$settings_file")"
    mkdir -p "$settings_dir"

    temporary_file="$(mktemp "$settings_file.tmp.XXXXXX")"
    trap 'rm -f "$temporary_file"' EXIT

    if [[ -f "$settings_file" ]]; then
      ${lib.getExe pkgs.jq} -s '
        (.[0] | { lastChangelogVersion, trackingId }
          | with_entries(select(.value != null))) * .[1]
      ' "$settings_file" ${managedSettingsFile} > "$temporary_file"
    else
      cp ${managedSettingsFile} "$temporary_file"
    fi

    chmod 600 "$temporary_file"
    mv "$temporary_file" "$settings_file"
  '';
in
{
  home.file.".pi/agent/AGENTS.md".text = aiAgentsInstructions;

  home.activation.piSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${updateSettings} ${lib.escapeShellArg settingsFile}
  '';
}
