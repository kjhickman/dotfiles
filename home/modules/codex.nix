{ pkgs, ... }:

{
  programs.codex.enable = true;

  # programs.codex module currently hardcodes its configuration path to ~/.codex/config.toml
  xdg.configFile."codex/config.toml".source = (pkgs.formats.toml { }).generate "codex-config" {
    model = "gpt-5.2-codex";
  };
}
