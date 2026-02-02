{ pkgs, config, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
        controlMaster = "auto";
        controlPath = "~/.ssh/master-%r@%h:%p";
        controlPersist = "10m";
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github_ed25519";
        extraOptions = {
          PreferredAuthentications = "publickey";
        };
      };
    };
  };
}
