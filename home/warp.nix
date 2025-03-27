{ config, pkgs, lib, ... }:

{
  home.file.".warp/themes/catppuccin_latte.yaml".text = ''
    background: '#eff1f5'
    accent: '#dc8a78'
    foreground: '#4c4f69'
    details: lighter
    terminal_colors:
      normal:
        black: '#5c5f77'
        red: '#d20f39'
        green: '#40a02b'
        yellow: '#df8e1d'
        blue: '#1e66f5'
        magenta: '#ea76cb'
        cyan: '#179299'
        white: '#acb0be'
      bright:
        black: '#6c6f85'
        red: '#d20f39'
        green: '#40a02b'
        yellow: '#df8e1d'
        blue: '#1e66f5'
        magenta: '#ea76cb'
        cyan: '#179299'
        white: '#bcc0cc'
  '';

  home.file.".warp/themes/catppuccin_macchiato.yaml".text = ''
    background: '#24273a'
    accent: '#f4dbd6'
    foreground: '#cad3f5'
    details: darker
    terminal_colors:
      normal:
        black: '#494d64'
        red: '#ed8796'
        green: '#a6da95'
        yellow: '#eed49f'
        blue: '#8aadf4'
        magenta: '#f5bde6'
        cyan: '#8bd5ca'
        white: '#b8c0e0'
      bright:
        black: '#5b6078'
        red: '#ed8796'
        green: '#a6da95'
        yellow: '#eed49f'
        blue: '#8aadf4'
        magenta: '#f5bde6'
        cyan: '#8bd5ca'
        white: '#a5adcb'
  '';
}