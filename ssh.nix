{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    
    # Generate a new ED25519 key for GitHub
    matchBlocks = {
      "github.com" = {
        host = "github.com";
        identityFile = "~/.ssh/github_ed25519";
      };
    };
  };
}
