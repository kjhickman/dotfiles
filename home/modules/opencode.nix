{ config, lib, pkgs, ... }:

{
  programs.opencode = {
    enable = true;
    settings = {
      theme = "catppuccin";
    };
  };

  xdg.configFile."opencode/opencode.json".force = true;

  home.activation.installSuperpowers = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    superpowers_dir="${config.home.homeDirectory}/.config/opencode/superpowers"
    superpowers_parent="${config.home.homeDirectory}/.config/opencode"

    if [ ! -d "$superpowers_dir/.git" ]; then
      mkdir -p "$superpowers_parent"
      ${pkgs.git}/bin/git clone https://github.com/obra/superpowers.git "$superpowers_dir"
    else
      ${pkgs.git}/bin/git -C "$superpowers_dir" fetch --all --prune
      ${pkgs.git}/bin/git -C "$superpowers_dir" pull --ff-only
    fi
  '';

  home.file."${config.home.homeDirectory}/.config/opencode/plugins/superpowers.js".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/opencode/superpowers/.opencode/plugins/superpowers.js";

  home.file."${config.home.homeDirectory}/.config/opencode/skills/superpowers".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/opencode/superpowers/skills";
}
