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
      "discord"
      "docker-desktop"
      "font-jetbrains-mono-nerd-font"
      "font-monaspace"
      "freac"
      "garmin-express"
      "ghostty"
      "google-chrome"
      "google-drive"
      "jetbrains-toolbox"
      "mullvad-vpn"
      "obsidian"
      "qbittorrent"
      "slack"
      "steam"
      "thaw"
      "visual-studio-code"
      "vorssaint"
      # "vlc"
      "zoom"
    ];
  };
}
