{ inputs, ... }:

{
  # Vendored show-me from https://github.com/humanlayer/skills/tree/main/plugins/show-me/skills/show-me
  home.file.".agents/skills/show-me".source = ../skills/show-me;
  home.file.".agents/skills/workflow".source = "${inputs.workflow}/skills/workflow";
}
