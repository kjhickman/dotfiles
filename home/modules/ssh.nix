{ pkgs, config, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;
        ControlMaster = "auto";
        ControlPath = "~/.ssh/master-%r@%h:%p";
        ControlPersist = "10m";
      };
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/github_ed25519";
        PreferredAuthentications = "publickey";
      };
    };
  };
}
