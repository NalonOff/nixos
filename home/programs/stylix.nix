{ config, pkgs, ... }:
let
  raw = builtins.fromJSON (builtins.readFile /home/nalon/colors.json);
  base16 = {
    scheme = raw.scheme or "custom";
    author = "converted";
    base00 = raw.special.background;
    base01 = raw.colors.color0;
    base02 = raw.colors.color1;
    base03 = raw.colors.color2;
    base04 = raw.colors.color4;
    base05 = raw.special.foreground;
    base06 = raw.colors.color7;
    base07 = raw.colors.color15;
    base08 = raw.colors.color1;
    base09 = raw.colors.color9;
    base0A = raw.colors.color3;
    base0B = raw.colors.color2;
    base0C = raw.colors.color6;
    base0D = raw.colors.color4;
    base0E = raw.colors.color5;
    base0F = raw.colors.color8;
  };
in {
  # Configuration complète de Stylix
  # Le module est importé via flake.nix, donc pas besoin d'imports ici
  stylix = {
    # Activer Stylix
    enable = true;

    # Image de fond (wallpaper) - Stylix génèrera automatiquement les couleurs
    # image = /home/nalon/.cache/current-wallpaper;  # Mettez votre image dans le dossier home/

    # Ou utiliser un schéma de couleurs prédéfini :
    base16Scheme = base16;

    # Configuration des polices
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = {
        package = pkgs.fira-code;
        name = "Fira Code";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      
      # Tailles des polices
      sizes = {
        applications = 12;
        terminal = 14;
        desktop = 10;
        popups = 12;
      };
    };

    # Curseur
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    # Applications à thématiser
    targets = {
      # Terminal/Shell
      kitty.enable = true;
      
      # Éditeurs
      vim.enable = true;
      neovim.enable = true;
      
      # Navigateurs
      firefox = {
        enable = true;
	profileNames = [ "default" ];
      };
      
      # Gestionnaires de fenêtres
      hyprland.enable = true;
      
      # Autres
      rofi.enable = true;
      dunst.enable = true;
      gtk.enable = true;
      nixcord.enable = true;
    };

    # Transparence
    opacity = {
      applications = 0.95;
      terminal = 0.9;
      desktop = 1.0;
      popups = 0.95;
    };

    # Mode sombre/clair
    polarity = "dark";  # ou "light"
  };
}
