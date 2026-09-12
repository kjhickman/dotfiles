{ aiAgentsInstructions, ... }:

{
  programs.codex = {
    enable = true;
    context = aiAgentsInstructions;
  };
}
