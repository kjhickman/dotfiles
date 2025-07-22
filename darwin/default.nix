{ pkgs, inputs, brew, ... }:
 
{
  imports = [ ./homebrew.nix ];

  # Set system hostname
  networking.hostName = "dalaran";
  networking.computerName = "Kyle's MacBook Pro";
  system.defaults.smb.NetBIOSName = "dalaran";

  # Installs homebrew
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "kyle";
  };

  system.primaryUser = "kyle";

  nixpkgs.config.allowUnfree = true;

  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Disable nix-darwin shell integrations
  # programs.bash.enable = false;
  # programs.fish.enable = false;
  # programs.zsh.enable = false;
  programs.zsh.enable = true;

  system.defaults = {
    dock.autohide = true;
    dock.autohide-time-modifier = 0.0;
    dock.autohide-delay = 0.0;
    dock.orientation = "bottom";
    dock.persistent-apps = [
      "/Applications/Brave Browser.app"
      "/Applications/Obsidian.app"
      "/Applications/Ghostty.app"
    ];
    dock.show-recents = false;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.GuestEnabled = false;
    NSGlobalDomain.ApplePressAndHoldEnabled = false;
    NSGlobalDomain.InitialKeyRepeat = 15;
    NSGlobalDomain.KeyRepeat = 1;
    NSGlobalDomain."com.apple.keyboard.fnState" = true;
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  security.pam.services.sudo_local.touchIdAuth = true;
}
