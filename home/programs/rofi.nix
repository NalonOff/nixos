{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    theme = {
      "*" = {
        bg-col = "#1e1e2e";
        bg-col-light = "#313244";
        border-col = "#89b4fa";
        selected-col = "#89b4fa";
        blue = "#89b4fa";
        fg-col = "#cdd6f4";
        fg-col2 = "#f38ba8";
        grey = "#6c7086";

        width = 600;
        font = "JetBrains Mono Nerd Font 12";
      };

      "element-text, element-icon , mode-switcher" = {
        background-color = "inherit";
        text-color = "inherit";
      };

      "window" = {
        height = 360;
        border = 3;
        border-color = "@border-col";
        border-radius = 15;
        background-color = "@bg-col";
        opacity = 0.8;
      };

      "mainbox" = {
        background-color = "@bg-col";
        border-radius = 15;
        padding = 15;
      };

      "inputbar" = {
        children = [ "prompt" "entry" ];
        background-color = "@bg-col-light";
        border-radius = 10;
        padding = 8;
        margin = "0px 0px 10px 0px";
        border = 2;
        border-color = "@border-col";
      };

      "prompt" = {
        background-color = "@blue";
        padding = 6;
        text-color = "@bg-col";
        border-radius = 8;
        margin = "0px 10px 0px 0px";
        font = "JetBrains Mono Nerd Font Bold 12";
      };

      "textbox-prompt-colon" = {
        expand = false;
        str = ":";
      };

      "entry" = {
        padding = 6;
        text-color = "@fg-col";
        background-color = "@bg-col-light";
        border-radius = 8;
        placeholder-color = "@grey";
        placeholder = "Rechercher...";
      };

      "listview" = {
        border = 0;
        padding = 6;
        columns = 1;
        lines = 8;
        cycle = true;
        dynamic = true;
        scrollbar = true;
        layout = "vertical";
        reverse = false;
        fixed-height = 0;
        fixed-columns = true;
        spacing = 5;
        background-color = "@bg-col";
        border-radius = 10;
      };

      "element" = {
        padding = 8;
        background-color = "@bg-col";
        text-color = "@fg-col";
        border-radius = 8;
        spacing = 8;
      };

      "element-icon" = {
        size = 24;
        border = 0;
        background-color = "inherit";
        text-color = "inherit";
      };

      "element-text" = {
        background-color = "inherit";
        text-color = "inherit";
        expand = true;
        horizontal-align = 0;
        vertical-align = 0.5;
        margin = "0px 0px 0px 10px";
      };

      "element selected" = {
        background-color = "@selected-col";
        text-color = "@bg-col";
        border-radius = 8;
      };

      "element selected.active" = {
        background-color = "@selected-col";
        text-color = "@bg-col";
      };

      "element selected.normal" = {
        background-color = "@selected-col";
        text-color = "@bg-col";
      };

      "element selected.urgent" = {
        background-color = "@selected-col";
        text-color = "@bg-col";
      };

      "element.active" = {
        background-color = "@bg-col-light";
        text-color = "@fg-col2";
      };

      "element.normal.active" = {
        background-color = "@bg-col-light";
        text-color = "@fg-col2";
      };

      "element.normal.urgent" = {
        background-color = "@bg-col-light";
        text-color = "@fg-col2";
      };

      "element.urgent" = {
        background-color = "@bg-col-light";
        text-color = "@fg-col2";
      };

      "scrollbar" = {
        width = 4;
        border = 0;
        handle-width = 8;
        handle-color = "@border-col";
        background-color = "@bg-col-light";
        border-radius = 10;
      };

      "mode-switcher" = {
        spacing = 0;
        background-color = "@bg-col";
        border-radius = 10;
        margin = "10px 0px 0px 0px";
      };

      "button" = {
        padding = 10;
        background-color = "@bg-col-light";
        text-color = "@grey";
        vertical-align = 0.5;
        horizontal-align = 0.5;
        border-radius = 8;
        margin = "0px 5px 0px 0px";
      };

      "button selected" = {
        background-color = "@selected-col";
        text-color = "@bg-col";
      };

      "message" = {
        background-color = "@bg-col-light";
        margin = 2;
        padding = 2;
        border-radius = 10;
        border = 2;
        border-color = "@border-col";
      };

      "textbox" = {
        padding = 8;
        margin = 20;
        text-color = "@fg-col";
        background-color = "@bg-col-light";
        border-radius = 8;
      };
    };

    extraConfig = {
      modi = "drun,run,window,ssh,combi";
      show-icons = true;
      terminal = "kitty";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = false;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 󰕰  Window";
      display-Network = " 󰤨  Network";
      sidebar-mode = true;
      matching = "fuzzy";
      sort = true;
      threads = 0;
      scroll-method = 0;
      window-format = "{w} · {c} · {t}";
      click-to-exit = true;
      combi-modi = "drun,run";

      # Configuration pour Wayland
      show = "drun";
      kb-row-up = "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
      kb-row-down = "Down,Control+j,Tab";
      kb-accept-entry = "Control+m,Return,KP_Enter";
      kb-remove-to-eol = "Control+Shift+e";
      kb-mode-next = "Shift+Right,Control+Tab";
      kb-mode-previous = "Shift+Left,Control+Shift+Tab";
      kb-remove-char-back = "BackSpace";
    };
  };
}
