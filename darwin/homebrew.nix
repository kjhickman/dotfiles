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
      "brave-browser"
      "bruno"
      "discord"
      "docker"
      "font-jetbrains-mono-nerd-font"
      "google-drive"
      "jordanbaird-ice"
      "keepingyouawake"
      "maccy"
      "mullvadvpn"
      "obsidian"
      "ppsspp"
      "qbittorrent"
      "rider"
      "slack"
      "steam"
      "visual-studio-code"
      "vlc"
      "wezterm"
      "zen-browser"
    ];
  };
}
