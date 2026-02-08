{ config, pkgs, ... }:
let
  home = config.home.homeDirectory;
  configHome = config.xdg.configHome;
  dataHome = config.xdg.dataHome;
  cacheHome = config.xdg.cacheHome;
in
{
  xdg.enable = true;
  programs.zoxide.enable = true;

  home.sessionPath = [
    "${cacheHome}/.bun/bin"
    "${home}/.dotnet/tools"
    "${home}/cargo/bin"
    "${home}/.aspire/bin"
  ];

  home.sessionVariables = {
    GOPATH = "${dataHome}/go";
    RUSTUP_HOME = "${dataHome}/rustup";
    CARGO_HOME = "${dataHome}/cargo";
    DOTNET_ROOT = "${pkgs.dotnet-sdk.outPath}";
    NUGET_PACKAGES = "${cacheHome}/NuGetPackages";
    AWS_CONFIG_FILE = "${configHome}/aws/config";
    AWS_SHARED_CREDENTIALS_FILE = "${configHome}/aws/credentials";
    CLAUDE_CONFIG_DIR = "${configHome}/claude"; # todo: find way to move to claudecode.nix?
    DOCKER_CONFIG = "${configHome}/docker";
    DOTNET_CLI_HOME = "${configHome}";
    BUN_INSTALL_DIR = "${configHome}/bun";
    CODEX_HOME = "${configHome}/codex";

    OPENCODE_ENABLE_EXA = "true";
  };
}
