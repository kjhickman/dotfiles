{ config, lib, pkgs, ... }:
{
  programs.opencode = {
    enable = true;
    tui = {
      theme = "catppuccin";
      scroll_acceleration.enabled = true;
    };
    settings = {
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

      agent.build.mode = "primary";
      agent.plan.mode = "primary";

      agent.explore.model = "github-copilot/claude-haiku-4.5";
    };
  };

  home.activation.removeOpencodeSuperpowers = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run rm -rf $VERBOSE_ARG "${config.xdg.configHome}/opencode/superpowers"
  '';

  xdg.configFile."opencode/opencode.json".force = true;
  xdg.configFile."opencode/AGENTS.md".text = ''
    ## Global Instructions

    - Do not add unnecessary comments in code.
    - Use as many subagents as logically makes sense when working on a task.
    - Use the `question` tool whenever asking the user a question.
    - Keep SOLID principles and Clean Code in mind, but apply them pragmatically and avoid being overly strict.
  '';
}
