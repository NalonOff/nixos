{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Variables d'environnement
      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];

      # Moniteurs
      monitor = [
        ",preferred,auto,auto"
      ];

      # Applications au démarrage
      exec-once = [
        # "waybar"
        # "hyprpaper"
        # "dunst"
        # "nm-applet --indicator"
        # "blueman-applet"
      ];

      # Variables générales
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      # Décoration
      decoration = {
        rounding = 10;
        
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # Animations
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Layout Dwindle
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Gestes
      gestures = {
        workspace_swipe = false;
      };

      # Divers
      misc = {
        force_default_wallpaper = -1;
      };

      # Règles pour les fenêtres
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "float,class:^(pavucontrol)$"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(splash)$"
        "float,class:^(confirmreset)$"
      ];

      # Raccourcis clavier
      "$mod" = "SUPER";
      
      bind = [
        # Applications
        "$mod, RETURN, exec, kitty"
        "$mod, A, killactive,"
        "$mod, M, exit,"
        # "$mod, E, exec, thunar"
        "$mod, V, togglefloating,"
        # "$mod, R, exec, rofi -show drun"
        # "$mod, P, pseudo,"
        # "$mod, J, togglesplit,"

        # Navigation entre les fenêtres
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Navigation entre les workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        # Déplacer les fenêtres vers les workspaces
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"

        # Navigation spéciale
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Scroll entre workspaces
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];

      # Raccourcis avec maintien
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
