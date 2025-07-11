{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    settings = {

      #background_opacity = 0.8;

      font_family = "FiraCode Nerd Font";
      bold_font = "FiraCode Nerd Font Bold";
      italic_font = "FiraCode Nerd Font Italic";
      font_size = 12.0;

      cursor_shape = "beam";
      cursor_blink_interval = 0;

      # Scrollback
      scrollback_lines = 10000;
    };
  };
}
