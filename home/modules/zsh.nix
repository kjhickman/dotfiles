{ lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableVteIntegration = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ope = "opencode";
    };

    initContent = ''
      export DOTNET_ROOT="$(realpath $(which dotnet))/.."
      export PATH="$HOME/.dotnet/tools:$HOME/.cargo/bin:$HOME/.aspire/bin:$PATH"
    '';
  };
}
