{ pkgs, config, ... }:

{
  programs.ssh = {
    enable = true;

    matchBlocks = {
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
