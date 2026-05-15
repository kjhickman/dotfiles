{ aiAgentsInstructions, config, lib, pkgs, ... }:
{
  programs.opencode = {
    enable = true;
    tui = {
      theme = "catppuccin";
      scroll_acceleration.enabled = true;
    };
    settings = {
      enabled_providers = [
        "openai"
        "github-copilot"
        "opencode-go"
        "google"
        "ollama"
      ];
      disabled_providers = [ "opencode" ];

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

      provider.ollama = {
        npm = "@ai-sdk/openai-compatible";
        name = "Ollama";
        options = {
          baseURL = "http://127.0.0.1:11434/v1";
          num_ctx = 16384;
        };
        models = {
          "gemma4:26b" = {
            name = "Gemma 4";
          };
        };
      };

      permission.external_directory = {
        "/private/tmp/**" = "allow";
        "/tmp/**" = "allow";
      };

      # codesearch currently broken
      permission.codesearch = "deny";

      agent.build.mode = "primary";
      agent.plan.mode = "primary";

      agent.explore.model = "github-copilot/claude-haiku-4.5";
    };
  };

  home.activation.removeOpencodeSuperpowers = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run rm -rf $VERBOSE_ARG "${config.xdg.configHome}/opencode/superpowers"
    run rm -rf $VERBOSE_ARG "${config.xdg.configHome}/opencode/skills/superpowers"
  '';

  xdg.configFile."opencode/opencode.json".force = true;
  xdg.configFile."opencode/AGENTS.md".text = aiAgentsInstructions;
}
