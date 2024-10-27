{ pkgs, inputs, brew, ... }:
 
{
  imports = [ ./homebrew.nix ];

  # Set system hostname
  networking.hostName = "dalaran";
  networking.computerName = "Kyle's MacBook Pro";
  system.defaults.smb.NetBIOSName = "dalarans";

  # Installs homebrew
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "kyle";
  };

  environment.systemPackages =
    [
      pkgs.neovim
      pkgs.tmux
    ];

  nixpkgs.config.allowUnfree = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina

  system.defaults = {
    dock.autohide = true;
    dock.autohide-time-modifier = 0.0;
    dock.autohide-delay = 0.0;
    dock.orientation = "left";
    dock.persistent-apps = [
      "/Applications/Brave Browser.app"
      "/Applications/Obsidian.app"
      "/Applications/WezTerm.app"
    ];
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.GuestEnabled = false;
    # NSGlobalDomain.AppleInterfaceStyle = "System";
    NSGlobalDomain.ApplePressAndHoldEnabled = false;
    NSGlobalDomain.InitialKeyRepeat = 10;
    NSGlobalDomain.KeyRepeat = 1;
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  security.pam.enableSudoTouchIdAuth = true;
}