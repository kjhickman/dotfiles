{ aiAgentsInstructions, generalCodeReviewInstructions, ... }:

{
  programs.codex = {
    enable = true;
    context = aiAgentsInstructions;
  };

  xdg.configFile."codex/agents/code-reviewer.toml".text = ''
    name = "code_reviewer"
    description = "Reviews code modifications, architecture, and file changes for bugs and risks."
    sandbox_mode = "read-only"

    developer_instructions = """
    ${generalCodeReviewInstructions}
    """
  '';

}
