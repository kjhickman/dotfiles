{ aiAgentsInstructions, generalCodeReviewInstructions, inputs, config, lib, pkgs, ... }:
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

      plugin = [
        "${inputs.ponytail}/.opencode/plugins/ponytail.mjs"
      ];

      provider.openai.whitelist = [
        "gpt-5.6-sol"
        "gpt-5.6-terra"
        "gpt-5.6-luna"
      ];

      provider.github-copilot.whitelist = [
        "claude-haiku-4.5"
        "claude-opus-4.8"
        "claude-fable-5"
        "gpt-5.6-sol"
        "gpt-5.6-terra"
        "gpt-5.6-luna"
      ];

      provider.opencode-go.whitelist = [
        "grok-4.5"
        "kimi-k3"
        "glm-5.2"
        "deepseek-v4-pro"
      ];

      provider.google.whitelist = [
        "gemini-3-flash-preview"
      ];

      # codesearch currently broken
      permission.codesearch = "deny";

      permission.edit."/nix/store/**" = "deny";
      permission.edit."${config.home.homeDirectory}/.cargo/**" = "deny";
      permission.edit."${config.xdg.dataHome}/cargo/**" = "deny";
      permission.edit."${config.xdg.cacheHome}/NuGetPackages/**" = "deny";

      permission.external_directory."~/.aspire/logs/**" = "allow";
      permission.external_directory."/nix/store/**" = "allow";
      permission.external_directory."${config.home.homeDirectory}/.cargo/**" = "allow";
      permission.external_directory."${config.xdg.dataHome}/cargo/**" = "allow";
      permission.external_directory."${config.xdg.cacheHome}/NuGetPackages/**" = "allow";

      agent.build.color = "secondary";
      agent.plan.color = "accent";

      agent.ask = {
        mode = "primary";
        color = "info";
        permission.edit = "deny";
        prompt = ''
          You are in Ask mode. Answer the user's question directly.

          Do not edit files, modify system state, or form an implementation plan unless the user explicitly asks for one.
          Use read-only tools as needed to inspect context, then give the concise answer.
        '';
      };
    };
  };

  xdg.configFile."opencode/opencode.json".force = true;
  xdg.configFile."opencode/AGENTS.md".text = aiAgentsInstructions;
  xdg.configFile."opencode/agent/code-review.md".text = ''
    ---
    description: Reviews code modifications, architecture, and file changes for bugs and risks.
    mode: subagent
    permission:
      edit: deny
    ---

    ${generalCodeReviewInstructions}
  '';
  xdg.configFile."opencode/command" = {
    source = "${inputs.ponytail}/.opencode/command";
    recursive = true;
  };
}
