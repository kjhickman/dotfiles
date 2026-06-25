{ inputs, ... }:

{
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "kyle";
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

    casks = [
      "battle-net"
      "brave-browser"
      "devtunnel"
      "discord"
      "docker-desktop"
      "firefox"
      "font-jetbrains-mono-nerd-font"
      "font-monaspace"
      "freac"
      "garmin-express"
      "ghostty"
      "google-chrome"
      "google-drive"
      "jetbrains-toolbox"
      "keepingyouawake"
      "lm-studio"
      "maccy"
      "mullvad-vpn"
      "obsidian"
      "qbittorrent"
      "slack"
      "steam"
      "thaw"
      "visual-studio-code"
      # "vlc"
      "zoom"
    ];
  };
}
