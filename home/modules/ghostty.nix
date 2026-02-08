{ lib, isWsl, ... }:

lib.mkIf (!isWsl) {
  programs.ghostty = {
    # Install with Homebrew on macOS
    package = null;

    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    settings = {
      # Behavior settings
      copy-on-select = "clipboard";

      # Appearance settings
      theme = "light:catppuccin-latte,dark:catppuccin-macchiato";
      window-height = 24;
      window-width = 80;

      # Font settings
      font-family = "Monaspace Neon";
      font-thicken = false;

      # Keybindings
      keybind = "shift+enter=text:\\n";
    };
  };
}
