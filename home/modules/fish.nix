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
  };
}
