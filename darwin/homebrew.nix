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
      "discord"
      "font-jetbrains-mono-nerd-font"
      "obsidian"
      "visual-studio-code"
      "wezterm"
    ];
  };
}
