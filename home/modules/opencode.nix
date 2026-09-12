{ aiAgentsInstructions, inputs, config, lib, pkgs, ... }:
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
      ];
      disabled_providers = [ "opencode" ];

      plugin = [
        "${inputs.ponytail}/.opencode/plugins/ponytail.mjs"
      ];

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
  xdg.configFile."opencode/command" = {
    source = "${inputs.ponytail}/.opencode/command";
    recursive = true;
  };
}
