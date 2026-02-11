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
    '';

    functions = {
      fish_prompt = ''
        if set -q __prmt_prompt_seen
          echo
        else
          set -g __prmt_prompt_seen 1
        end

        prmt --shell none --no-version --code $status '{path:cyan} {git:purple}\n{ok:green}{fail:red} '
      '';
    };
  };
}
