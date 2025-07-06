
{ config, pkgs, lib, ... }:

{
  stylix = {
    enable = true;

    # Configuration du thème Everforest
    # Option 1: Utiliser le schéma Everforest depuis base16-schemes
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";

    # Option 2: Configuration Everforest manuelle (décommentez pour utiliser à la place)
    # base16Scheme = {
    #   base00 = "2d353b"; # Background
    #   base01 = "343f44"; # Lighter Background
    #   base02 = "3d484d"; # Selection Background
    #   base03 = "543a48"; # Comments
    #   base04 = "859289"; # Dark Foreground
    #   base05 = "d3c6aa"; # Default Foreground
    #   base06 = "e9e8d2"; # Light Foreground
    #   base07 = "fff9e8"; # Light Background
    #   base08 = "e67e80"; # Red
    #   base09 = "e69875"; # Orange
    #   base0A = "dbbc7f"; # Yellow
    #   base0B = "a7c080"; # Green
    #   base0C = "83c092"; # Cyan
    #   base0D = "7fbbb3"; # Blue
    #   base0E = "d699b6"; # Magenta
    #   base0F = "d699b6"; # Brown
    # };

    # Option 3: Utiliser une image comme base (décommentez pour utiliser)
    # image = ./wallpapers/everforest-wallpaper.jpg;

    # Configuration des polices
    fonts = {
      monospace = {
        name = "FiraCode Nerd Font Mono";
      };
      sansSerif = {
        name = "Noto Sans";
      };
      serif = {
        name = "Noto Serif";
      };
      emoji = {
        name = "Noto Color Emoji";
      };

      # Tailles des polices
      sizes = {
        terminal = 12;
        applications = 11;
        popups = 10;
        desktop = 10;
      };
    };

    # Configuration du curseur
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    # Opacité globale
    opacity = {
      terminal = 0.9;
      applications = 1.0;
      popups = 0.95;
      desktop = 1.0;
    };

    # Configuration des cibles (targets)
    targets = {
      # Hyprland
      hyprland.enable = true;

      # Applications GUI
      gtk.enable = true;
      qt.enable = true;

      # Terminaux
      kitty.enable = true;

      # Éditeurs
      neovim.enable = true;

      # Navigateurs
      firefox.enable = true;

      # Autres applications
      rofi.enable = true;
      waybar.enable = true;
      mako.enable = true;
      dunst.enable = true;

      spicetify.enable = true;
      nixcord.enable = true;

      # Shell
      starship.enable = true;

      # Media
      mpv.enable = true;
     };

    # Configuration avancée
    polarity = "dark"; # "dark" ou "light"

    # Personnalisation par application (exemples)
    # Override des couleurs spécifiques si nécessaire
    # colors = {
    #   # Vous pouvez override des couleurs spécifiques ici
    # };
  };
}
