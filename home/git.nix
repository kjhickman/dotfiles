{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    userName = "Kyle Hickman";
    userEmail = "kyle@txhickman.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
      core.autocrlf = "input";
      push.default = "current";

      # Git Aliases
      alias.co = "switch";
      alias.up = "!git pull --rebase --prune $@ && git submodule update --init --recursive";
      alias.cob = "switch -c";
      alias.cm = "!git add -A && git commit -m";
      alias.save = "!git add -A && git commit -m 'wip'";
      alias.undo = "reset HEAD~1 --mixed";
      alias.diffshow =  "!f() { git diff \$1 \${2-HEAD} --name-status ; }; f";
    };
  };
}
