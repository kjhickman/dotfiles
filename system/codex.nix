{ pkgs, ... }:

{
  environment.etc."codex/config.toml".source = (pkgs.formats.toml { }).generate "codex-config.toml" {
    model = "gpt-5.6-sol";
    web_search = "live";

    mcp_servers.gh_grep = {
      enabled = true;
      url = "https://mcp.grep.app";
    };

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
