{ config, lib, pkgs, ... }:

let
  superpowersSkillNames = [
    "brainstorming"
    "dispatching-parallel-agents"
    "executing-plans"
    "finishing-a-development-branch"
    "receiving-code-review"
    "requesting-code-review"
    "subagent-driven-development"
    "systematic-debugging"
    "test-driven-development"
    "using-git-worktrees"
    "using-superpowers"
    "verification-before-completion"
    "writing-plans"
    "writing-skills"
  ];

  superpowersSkillPermissions = lib.recursiveUpdate {
    "*" = "allow";
  } (lib.listToAttrs (map (skill: {
    name = skill;
    value = "deny";
  }) superpowersSkillNames));
in
{
  programs.opencode = {
    enable = true;
    settings = {
      theme = "catppuccin";

      tui.scroll_acceleration.enabled = true;
      permission.external_directory = {
        "/private/tmp/**" = "allow";
        "/tmp/**" = "allow";
      };

      # Keep build/plan as the primary agents and deny superpowers there
      agent.build.mode = "primary";
      agent.plan.mode = "primary";
      agent.build.permission.skill = superpowersSkillPermissions;
      agent.plan.permission.skill = superpowersSkillPermissions;

      agent.explore.model = "github-copilot/claude-haiku-4.5";

      agent.superman = {
        mode = "subagent";
        description = "Build agent with Superpowers workflow";
        permission = {
          skill = {
            "*" = "allow";
          };
        };
        prompt = ''
          <EXTREMELY_IMPORTANT>
          You have superpowers.

          **IMPORTANT: The using-superpowers skill content is included below. It is ALREADY LOADED - you are currently following it. Do NOT use the skill tool to load "using-superpowers" again - that would be redundant.**

          {file:${config.home.homeDirectory}/.config/opencode/superpowers/skills/using-superpowers/SKILL.md}

          **Tool Mapping for OpenCode:**
          When skills reference tools you don't have, substitute OpenCode equivalents:
          - `TodoWrite` -> `todowrite`
          - `Task` tool with subagents -> Use OpenCode's subagent system (@mention)
          - `Skill` tool -> OpenCode's native `skill` tool
          - `Read`, `Write`, `Edit`, `Bash` -> Your native tools

          **Skills location:**
          Superpowers skills are in `${config.home.homeDirectory}/.config/opencode/skills/superpowers/`
          Use OpenCode's native `skill` tool to list and load skills.
          </EXTREMELY_IMPORTANT>
        '';
      };
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
