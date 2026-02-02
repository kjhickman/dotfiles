{ pkgs, ...}: 

{
  programs.opencode = {
    enable = true;
    settings = {
      theme = "catppuccin";
    };
  };

  xdg.configFile."opencode/opencode.json".force = true;
}
