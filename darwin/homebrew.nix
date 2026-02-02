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
      "dotnet-sdk"
      "dotnet-sdk@8"
      "dotnet-sdk@9"
      "firefox"
      "font-jetbrains-mono-nerd-font"
      "font-monaspace"
      "freac"
      "garmin-express"
      "ghostty"
      "godot"
      "google-chrome"
      "google-drive"
      "jordanbaird-ice"
      "keepingyouawake"
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
