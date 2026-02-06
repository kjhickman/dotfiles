{ lib, pkgs, ... }:

{
  home.sessionPath = [
    "$HOME/.dotnet/tools"
    "$HOME/.cargo/bin"
    "$HOME/.aspire/bin"
  ];

  programs.zsh = {
    enable = true;

    enableVteIntegration = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      cat = "bat";
      ls = "eza";
      tf = "terraform";
      ope = "opencode";
    };

    initContent = ''
      # Case-insensitive completion matching.
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
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
