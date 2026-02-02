{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      ope = "opencode";
    };

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    
    shellInitLast = ''
      enable_transience
    '';
  };
}
