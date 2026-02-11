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
        prmt --shell none --code $status '{path:cyan} {git:purple}\n{ok:green}{fail:red} '
      '';
    };
  };
}
