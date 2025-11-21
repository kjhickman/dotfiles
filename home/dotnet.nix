{ config, pkgs, ... }:

{
  # .NET SDK installed via Homebrew to avoid macOS code signing issues
  # See homebrew.nix for dotnet-sdk@8, dotnet-sdk@9, and dotnet-sdk (latest)
  home.packages = [ ];
}
