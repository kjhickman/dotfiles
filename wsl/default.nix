{ config, lib, pkgs, inputs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "kyle";
  wsl.wslConf.automount.mountFsTab = true;

  fileSystems."/mnt/g" = {
    device = "G:";
    fsType = "drvfs";
    options = [ "metadata" "uid=1000" "gid=100" "nofail" "noauto" "x-systemd.automount" ];
  };

  environment.systemPackages = [
    pkgs.wget # needed for VSCode remote
    pkgs.docker
    pkgs.gcc
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  services.dbus.implementation = "dbus";

  programs.fish.enable = true;
  users.users.kyle.shell = pkgs.fish;
  users.users.kyle.extraGroups = [ "docker" ];
  programs.fish.shellAbbrs = {
    nsw = "sudo nixos-rebuild switch --flake ~/repos/dotfiles#wsl";
  };

  # needed for VSCode remote
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    icu
    openssl
    zlib
    curl
    stdenv.cc.cc

    # Needed for Bun/Playwright downloaded Chromium on NixOS/WSL.
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    glib
    gobject-introspection
    libdrm
    libGL
    libgbm
    libxkbcommon
    nspr
    nss
    pango
    pciutils
    systemd
    vulkan-loader
    libx11
    libxcb
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxrandr
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05";
}
