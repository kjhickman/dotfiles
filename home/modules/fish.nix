{ pkgs, ... }:
let
  sharedAliases = import ../shell/aliases.nix;
  sharedAbbrs = import ../shell/abbrs.nix;
in
{
  programs.fish = {
    enable = true;

    shellAliases = sharedAliases.aliases;
    shellAbbrs = sharedAbbrs.abbrs;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set -g fish_transient_prompt 1
    '';

    functions = {
      fish_prompt = ''
        set -l last_status $status

        if contains -- --final-rendering $argv
          prmt --shell none --no-version --code $last_status '{path:cyan:s} {ok:green}{fail:red} '
          return
        end

        if set -q __prmt_prompt_seen
          echo
        else
          set -g __prmt_prompt_seen 1
        end

        prmt --shell none --no-version --code $last_status '{path:cyan} {git:purple}\n{ok:green}{fail:red} '
      '';
    };
  };
}
