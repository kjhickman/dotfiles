{ aiAgentsInstructions, ... }:

{
  programs.codex = {
    enable = true;
    context = aiAgentsInstructions;
    settings = {
      model = "gpt-5.6-terra";
      web_search = "live";

      mcp_servers.gh_grep = {
        enabled = true;
        url = "https://mcp.grep.app";
      };

      features.prevent_idle_sleep = true;

      tui = {
        status_line = [
          "model-with-reasoning"
          "five-hour-limit"
          "weekly-limit"
          "context-used"
          "current-dir"
        ];
        terminal_title = [
          "spinner"
          "project"
          "thread"
        ];
      };

      # Leave `tui.theme` unset so Codex keeps its built-in Catppuccin
    };
  };

  xdg.configFile."codex/agents/code-reviewer.toml".text = ''
    name = "code_reviewer"
    description = "Reviews code modifications, architecture, and file changes for bugs and risks."
    sandbox_mode = "read-only"

    developer_instructions = """
    Review code for correctness, security, behavior regressions, architecture risks, and missing tests.
    Do not edit files.
    Lead with findings, include file and line references, and state explicitly when no issues are found.
    """
  '';

}
