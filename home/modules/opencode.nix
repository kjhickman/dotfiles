{ aiAgentsInstructions, config, lib, pkgs, ... }:
{
  programs.opencode = {
    enable = true;
    tui = {
      theme = "catppuccin";
      scroll_acceleration.enabled = true;
    };
    settings = {
      lsp = true;

      enabled_providers = [
        "openai"
        "github-copilot"
        "opencode-go"
        "google"
        "ollama"
      ];
      disabled_providers = [ "opencode" ];

      mcp.gh_grep = {
        type = "remote";
        url = "https://mcp.grep.app";
        enabled = true;
      };

      provider.openai.whitelist = [
        "gpt-5.5"
        "gpt-5.4-mini"
      ];

      provider.github-copilot.whitelist = [
        "claude-haiku-4.5"
        "claude-sonnet-4.6"
        "claude-opus-4.7"
        "gpt-5.5"
      ];

      provider.opencode-go.whitelist = [
        "glm-5.1"
        "kimi-k2.6"
        "deepseek-v4-flash"
      ];

      provider.google.whitelist = [
        "gemini-3-flash-preview"
      ];

      # codesearch currently broken
      permission.codesearch = "deny";

      agent.build.mode = "primary";
      agent.plan.mode = "primary";

      agent.explore.model = "github-copilot/claude-haiku-4.5";
    };
  };

  xdg.configFile."opencode/opencode.json".force = true;
  xdg.configFile."opencode/AGENTS.md".text = aiAgentsInstructions;
}
