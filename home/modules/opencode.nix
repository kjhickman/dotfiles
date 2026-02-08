{ config, lib, pkgs, ... }:

let
  superpowersSkillPermissions = {
    "*" = "allow";
    "subagent-driven-development" = "deny";
    "verification-before-completion" = "deny";
    "writing-skills" = "deny";
    "receiving-code-review" = "deny";
    "requesting-code-review" = "deny";
    "writing-plans" = "deny";
    "brainstorming" = "deny";
    "finishing-a-development-branch" = "deny";
    "executing-plans" = "deny";
    "dispatching-parallel-agents" = "deny";
    "using-superpowers" = "deny";
    "systematic-debugging" = "deny";
    "test-driven-development" = "deny";
    "using-git-worktrees" = "deny";
  };
in
{
  programs.opencode = {
    enable = true;
    settings = {
      theme = "catppuccin";

      # Disallow superpowers outside of the superman agent
      agent.build.permission.skill = superpowersSkillPermissions;
      agent.plan.permission.skill = superpowersSkillPermissions;

      agent.superman = {
        mode = "primary";
        description = "Build agent with Superpowers workflow";
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
