{ lib, pkgs, ... }:

{
  home.packages = [ pkgs.cursor-cli ];

  home.file.".local/bin/agent".source = lib.getExe pkgs.cursor-cli;
}
