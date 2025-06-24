{ config, pkgs, ... }:

{
  # Configuration complète de Stylix
  # Le module est importé via flake.nix, donc pas besoin d'imports ici
  stylix = {
    # Activer Stylix
    enable = true;

    # Image de fond (wallpaper) - Stylix génèrera automatiquement les couleurs
    image = /home/nalon/.cache/current-wallpaper.jpg;  # Mettez votre image dans le dossier home/

    # Ou utiliser un schéma de couleurs prédéfini :
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

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
      discord.enable = true;
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
