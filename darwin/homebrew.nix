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
      "curseforge"
      "discord"
      "docker"
      "firefox"
      "font-jetbrains-mono-nerd-font"
      "ghostty"
      "godot"
      "google-drive"
      "jordanbaird-ice"
      "keepingyouawake"
      "maccy"
      "mullvadvpn"
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
