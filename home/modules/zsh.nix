{ lib, pkgs, config, ... }:
let
  sharedAliases = import ../shell/aliases.nix;
  sharedAbbrs = import ../shell/abbrs.nix;
in
{
  programs.zsh = {
    enable = true;

    enableVteIntegration = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    shellAliases = sharedAliases.aliases // sharedAbbrs.abbrs;

    initContent = ''
      # Case-insensitive completion matching.
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      setopt PROMPT_SUBST
      PROMPT='$(prmt --shell zsh --code $? "{path:cyan} {git:purple}\n{ok:green}{fail:red} ")'
    '';

    loginExtra = lib.mkIf pkgs.stdenv.isDarwin ''
      # Non-POSIX-compliant shells (for example, fish) should not be set as user
      # login shell. Exec said shell here as a workaround if desired.
      if [[ $(ps -p $PPID -o comm=) != "fish" && -z $ZSH_EXECUTION_STRING ]]; then
          (( $+commands[fish] )) && exec fish
      fi
    '';
  };
}
