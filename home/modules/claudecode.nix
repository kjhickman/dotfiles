{ pkgs, ...}: 

{
  programs.claude-code = {
    enable = true;

    settings = {
      autoUpdate = false;
    };
  };
}