{ aiAgentsInstructions, ... }:

{
  programs.codex = {
    enable = true;
    context = aiAgentsInstructions;
    settings = {
      model = "gpt-5.4";

      features.prevent_idle_sleep = true;

      tui = {
        status_line = [
          "model-with-reasoning"
          "five-hour-limit"
          "weekly-limit"
          "context-used"
          "current-dir"
        ];
        terminal_title = [
          "spinner"
          "project"
          "thread"
        ];
      };

      # Leave `tui.theme` unset so Codex keeps its built-in Catppuccin
      # auto-selection: latte on light terminals, mocha on dark terminals.
    };
  };
}
