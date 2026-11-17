{ inputs, ... }:

{
  # Vendored show-me from https://github.com/humanlayer/skills/tree/main/plugins/show-me/skills/show-me
  home.file.".agents/skills/show-me".source = ../skills/show-me;
  # Vendored prune-tests from https://github.com/caldoai/skills/tree/main/skills/prune-tests
  home.file.".agents/skills/prune-tests".source = ../skills/prune-tests;
  home.file.".agents/skills/ponytail-review".source = "${inputs.ponytail}/skills/ponytail-review";
  home.file.".agents/skills/ponytail-audit".source = "${inputs.ponytail}/skills/ponytail-audit";
}
