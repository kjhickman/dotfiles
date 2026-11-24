{ lib, pkgs, ... }:

let
  browse = pkgs.callPackage ../../pkgs/browse { };
in
{
  home.packages = [ browse ];

  programs.opencode = {
    enable = true;
    settings = {
      enabled_providers = [
        "openai"
        "github-copilot"
        "opencode-go"
        "google"
        "claude-agent"
      ];
      disabled_providers = [ "opencode" ];

      mcp.servers.browse = {
        type = "local";
        command = [ (lib.getExe browse) "mcp" ];
        cwd = "~";
        pool = true;
      };

      permissions = [{
        action = "browse_*";
        resource = "*";
        effect = "ask";
      }];

      agents.build.color = "#b4befe";
      agents.plan.color = "#cba6f7";

      agents.ask = {
        mode = "primary";
        color = "#89b4fa";
        permissions = [
          {
            action = "edit";
            resource = "*";
            effect = "deny";
          }
          {
            action = "browse_*";
            resource = "*";
            effect = "deny";
          }
        ];
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
}
