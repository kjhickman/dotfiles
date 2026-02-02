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
  };
}
