{ inputs, ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

    casks = [
      "discord"
      "docker-desktop"
      "firefox"
      "font-jetbrains-mono-nerd-font"
      "ghostty"
      "godot"
      "google-chrome"
      "google-drive"
      "jordanbaird-ice"
      "keepingyouawake"
      "lm-studio"
      "maccy"
      "mullvad-vpn"
      "obsidian"
      "qbittorrent"
      "rider"
      "slack"
      "steam"
      "visual-studio-code"
      "vlc"
      "zoom"
    ];
  };
}
