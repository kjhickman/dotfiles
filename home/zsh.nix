{ lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableVteIntegration = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };
}
