{ aiAgentsInstructions, generalCodeReviewInstructions, ... }:

{
  programs.codex = {
    enable = true;
    context = aiAgentsInstructions;
  };
}
