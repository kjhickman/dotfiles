# AGENTS.md

This is my personal Nix flake for macOS and NixOS-WSL machines.

## Map

- `flake.nix` defines `darwinConfigurations.macos` and `nixosConfigurations.wsl`.
- `darwin/` contains nix-darwin system settings and Homebrew packages.
- `wsl/` contains NixOS-WSL system settings.
- `home/` contains shared Home Manager config; `home/modules/*.nix` are imported automatically by `home/default.nix`.
- `home/shell/` contains shared shell aliases and abbreviations.

## Working Rules

- Make surgical changes; this is a personal dotfiles repo, so avoid broad refactors unless asked.
- Prefer adding platform-specific settings under `darwin/` or `wsl/`; put shared user config under `home/`.
- When adding a Home Manager module, place it in `home/modules/`; it does not need to be manually added to imports.
