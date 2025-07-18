{ lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableVteIntegration = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      export DOTNET_ROOT="/etc/profiles/per-user/kyle/bin/dotnet"
      export PATH="$HOME/.dotnet/tools:$HOME/.cargo/bin:$PATH"
    '';

    # loginExtra = lib.mkIf pkgs.stdenv.isDarwin ''
    #   # macOS updates clear /etc/zshrc back to Apple defaults; this segment was
    #   # taken from that file.
    #   # Nix
    #   if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    #     . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    #   fi
    #   # End Nix

    #   # Non-POSIX-compliant shells (for example, fish) should not be set as user
    #   # login shell. Exec said shell here as a workaround if desired.
    #   if [[ $(ps -p $PPID -o comm=) != "fish" && -z $ZSH_EXECUTION_STRING ]]; then
    #       (( $+commands[fish] )) && exec fish
    #   fi
    # '';
  };
}
