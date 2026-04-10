{ config, lib, pkgs, ... }:
{
  programs.opencode = {
    enable = true;
    tui = {
      theme = "catppuccin";
      show_thinking = false;
      scroll_acceleration.enabled = true;
    };
    settings = {
      provider.ollama = {
        npm = "@ai-sdk/openai-compatible";
        name = "Ollama (local)";
        options.baseURL = "http://127.0.0.1:11434/v1";
        models = {
          "gemma4" = {
            name = "Gemma 4 (local)";
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

  xdg.configFile."opencode/opencode.json".force = true;
  xdg.configFile."opencode/AGENTS.md".text = ''
    ## Global Instructions

    - Do not add unnecessary comments in code.
    - Use as many subagents as logically makes sense when working on a task.
    - Use the `question` tool whenever asking the user a question.
    - Keep SOLID principles and Clean Code in mind, but apply them pragmatically and avoid being overly strict.
  '';

  home.activation.installSuperpowers = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    superpowers_dir="${config.home.homeDirectory}/.config/opencode/superpowers"
    superpowers_parent="${config.home.homeDirectory}/.config/opencode"

    if [ ! -d "$superpowers_dir/.git" ]; then
      mkdir -p "$superpowers_parent"
      ${pkgs.git}/bin/git clone https://github.com/obra/superpowers.git "$superpowers_dir"
    else
      ${pkgs.git}/bin/git -C "$superpowers_dir" fetch --all --prune
      ${pkgs.git}/bin/git -C "$superpowers_dir" pull --ff-only
    fi
  '';

  home.file."${config.home.homeDirectory}/.config/opencode/skills/superpowers".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/opencode/superpowers/skills";
}
