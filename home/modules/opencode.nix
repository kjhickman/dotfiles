{ aiAgentsInstructions, inputs, config, lib, pkgs, ... }:
{
  programs.opencode = {
    enable = true;
    tui = {
      theme = "catppuccin";
      scroll_acceleration.enabled = true;
    };
    settings = {
      lsp = true;

      enabled_providers = [
        "openai"
        "github-copilot"
        "opencode-go"
        "google"
        "ollama"
      ];
      disabled_providers = [ "opencode" ];

      mcp.gh_grep = {
        type = "remote";
        url = "https://mcp.grep.app";
        enabled = true;
      };

      plugin = [
        "${inputs.ponytail}/.opencode/plugins/ponytail.mjs"
      ];

      provider.openai.whitelist = [
        "gpt-5.5"
        "gpt-5.4-mini"
      ];

      provider.github-copilot.whitelist = [
        "claude-haiku-4.5"
        "claude-sonnet-4.6"
        "claude-opus-4.8"
        "gpt-5.5"
      ];

      provider.opencode-go.whitelist = [
        "glm-5.1"
        "kimi-k2.6"
        "deepseek-v4-flash"
      ];

      provider.google.whitelist = [
        "gemini-3-flash-preview"
      ];

      # codesearch currently broken
      permission.codesearch = "deny";

      permission.external_directory."~/.aspire/logs/**" = "allow";

      agent.ask = {
        mode = "primary";
        permission.edit = "deny";
        prompt = ''
          You are in Ask mode. Answer the user's question directly.

          Do not edit files, modify system state, or form an implementation plan unless the user explicitly asks for one.
          Use read-only tools as needed to inspect context, then give the concise answer.
        '';
      };
    };
  };

  xdg.configFile."opencode/opencode.json".force = true;
  xdg.configFile."opencode/AGENTS.md".text = aiAgentsInstructions;
  xdg.configFile."opencode/agent/code-review.md".text = ''
    ---
    description: Reviews code modifications, architecture, and file changes for bugs and risks.
    mode: subagent
    permission:
      edit: deny
    ---

    You are an expert Code Reviewer subagent. Your goal is to provide critical, objective, and constructive feedback on code modifications, structural architecture, and file changes.

    ### Core Directive
    Analyze code for bugs, architectural missteps, performance bottlenecks, and deviations from modern best practices. Do NOT modify any files yourself. Your tool footprint must be read-only for codebase state alterations, though you may run tests or build scripts using `bash` to verify compliance.

    ### Review Matrix
    1. **Correctness & Safety**: Check for edge cases, null reference potentials, flawed error handling, and logical race conditions.
    2. **Performance & Memory**: Look out for unnecessary allocations, suboptimal loops, inefficient lookups, or synchronous blocks masking as async.
    3. **Architecture & Readability**: Enforce clear separation of concerns, DRY principles, and proper dependency layouts.
    4. **Testing**: Verify that code paths are thoroughly covered by test definitions.

    ### Style & Guardrails
    - Keep your output concise and structured. Use Markdown lists referencing specific files and line numbers.
    - Group your feedback into "Critical Bugs", "Performance/Optimizations", and "Minor/Style Notes".
    - If the changes look solid, explicitly state that the code is ready for integration.
  '';
  xdg.configFile."opencode/command" = {
    source = "${inputs.ponytail}/.opencode/command";
    recursive = true;
  };
}
