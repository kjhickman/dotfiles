{ pkgs, inputs, brew, ... }:

{
  imports = [ ./homebrew.nix ];

  networking.hostName = "dalaran";
  networking.computerName = "Kyle's MacBook Pro";
  system.defaults.smb.NetBIOSName = "dalaran";
  system.primaryUser = "kyle";

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";

  # Darwin-specific aliases
  environment.shellAliases = {
    nix-switch = "sudo darwin-rebuild switch --flake ~/repos/dotfiles#macos";
  };
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # System defaults
  system.defaults = {
    dock.autohide = true;
    dock.autohide-time-modifier = 0.0;
    dock.autohide-delay = 0.0;
    dock.orientation = "bottom";
    dock.persistent-apps = [
      "/Applications/Google Chrome.app"
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

  security.pam.services.sudo_local.touchIdAuth = true;

  # System metadata
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 5;
}
