{ pkgs, ... }:

{
  environment.etc."codex/config.toml".source = (pkgs.formats.toml { }).generate "codex-config.toml" {
    model = "gpt-5.6-sol";
    web_search = "live";
    features.prevent_idle_sleep = true;

    tui = {
      status_line = [
        "model-with-reasoning"
        "context-used"
        "five-hour-limit"
        "weekly-limit"
      ];
      terminal_title = [
        "spinner"
        "app-name"
        "project"
      ];

      # Leave `tui.theme` unset
    };
  };
}
