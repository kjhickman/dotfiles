{ pkgs, lib, ... }:

let
  prmt = pkgs.prmt.overrideAttrs (oldAttrs: {
    checkFlags = (oldAttrs.checkFlags or [ ]) ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
      "--skip=modules::path::tests::relative_path_inside_home_renders_tilde"
      "--skip=modules::path::tests::relative_path_with_shared_prefix_is_not_tilde"
    ];
  });
in
{
  home.packages = with pkgs; [
    # general
    bat
    coreutils
    eza
    difftastic
    neovim
    nixd
    prmt
    ripgrep
    sqlite
    tldr
    msedit

    # cloud
    awscli2
    flyctl

    #dev
    bun
    deno
    go
    gh
    just
    k6
    nodejs_24
    ollama
    playwright
    powershell
    rustup
    selene
    stylua
    # terraform
    opentofu
    typescript
    uv
    zig
    zls
    # misc
    hledger
    hledger-ui
    hledger-web
    fastchess
    stockfish
  ] ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
    xdg-utils
  ];
}
