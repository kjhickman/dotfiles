{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      cc = "opencode";
    };

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    
    shellInitLast = ''
      enable_transience
    '';
  };
}
