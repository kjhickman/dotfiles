{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Kyle Hickman";
        email = "kyle@txhickman.com";
      };
      branch.sort = "-committerdate";
      column.ui = "auto";
      commit.verbose = true;
      core.editor = "nvim";
      core.autocrlf = "input";
      core.excludesfile = "~/.gitignore";
      help.autocorrect = "prompt";
      init.defaultBranch = "main";
      tag.sort = "version:refname";

      alias.co = "switch";
      alias.up = "!git pull --rebase --prune $@ && git submodule update --init --recursive";
      alias.cob = "switch -c";
      alias.cm = "!git add -A && git commit -m";
      alias.save = "!git add -A && git commit -m 'wip'";
      alias.undo = "reset HEAD~1 --mixed";
      alias.diffshow =  "!f() { git diff \$1 \${2-HEAD} --name-status ; }; f";
      alias.backdate = "!f() { GIT_AUTHOR_DATE=\"$(date -d \"$1\")\" GIT_COMMITTER_DATE=\"$(date -d \"$1\")\" git commit -m \"$2\"; }; f";

      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };

      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };

      rerere = {
        enabled = true;
        autoupdate = true;
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };
    };
  };
}
