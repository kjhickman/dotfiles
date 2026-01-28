{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      oc = "opencode";
    };

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    
    shellInitLast = ''
      enable_transience
    '';
  };
}
