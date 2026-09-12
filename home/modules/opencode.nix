{ aiAgentsInstructions, ... }:
{
  programs.opencode = {
    enable = true;
    settings = {
      enabled_providers = [
        "openai"
        "github-copilot"
        "opencode-go"
        "google"
      ];
      disabled_providers = [ "opencode" ];

      agents.build.color = "#b4befe";
      agents.plan.color = "#cba6f7";

      agents.ask = {
        mode = "primary";
        color = "#89b4fa";
        permissions = [{
          action = "edit";
          resource = "*";
          effect = "deny";
        }];
        system = ''
          You are in Ask mode. Answer the user's question directly.

          Do not edit files, modify system state, or form an implementation plan unless the user explicitly asks for one.
          Use read-only tools as needed to inspect context, then give the concise answer.
        '';
      };
    };
  };

  xdg.configFile."opencode/opencode.json".force = true;
  xdg.configFile."opencode/cli.json" = {
    force = true;
    text = builtins.toJSON {
      "$schema" = "https://opencode.ai/v2/cli.json";
      plugins = [ "opencode-bytheway@0.8.1" ];
      theme.name = "catppuccin";
      scroll.acceleration = true;
      diffs.wrap = "word";
      session = {
        sidebar = "auto";
        scrollbar = true;
        thinking = "hide";
      };
      animations = true;
    };
  };
  xdg.configFile."opencode/AGENTS.md".text = aiAgentsInstructions;
}
