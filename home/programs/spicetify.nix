{ config, pkgs, lib, ... }:

{
  # Configuration complète de Spicetify
  programs.spicetify = {
    enable = true;
    
    # Thème principal
    theme = {
      name = "catppuccin";  # Autres options: "dribbblish", "sleek", "text", etc.
      src = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "spicetify";
        rev = "v1.2.0";
        sha256 = "sha256-gEu8YPUKZxYPZANGJYJz/1xIWcYNOj0Xcp0QMfxhSsg=";
      };
      # Variante de couleur pour le thème
      colorScheme = "mocha";  # mocha, macchiato, frappe, latte pour catppuccin
    };
    
    # Extensions populaires
    enabledExtensions = [
      "adblock"           # Bloque les pubs
      "hidePodcasts"      # Cache la section podcasts
      "shuffle+"          # Améliore le shuffle
      "keyboardShortcut"  # Raccourcis clavier personnalisés
      "fullAppDisplay"    # Affichage plein écran amélioré
      "songStats"         # Statistiques des chansons
      "history"           # Historique d'écoute
      "beautifulLyrics"   # Paroles améliorées
      "powerBar"          # Barre de contrôle avancée
      "volumePercentage"  # Affiche le pourcentage du volume
    ];
    
    # Applications personnalisées (optionnel)
    enabledCustomApps = [
      "lyrics-plus"       # App paroles avancée
      "new-releases"      # Nouvelles sorties
      "reddit"           # Intégration Reddit
    ];
    
    # Configuration avancée
    injectCss = true;     # Permet l'injection CSS personnalisée
    replaceColors = true; # Remplace les couleurs par le thème
    overwriteAssets = true; # Remplace les assets
    
    # CSS personnalisé (optionnel)
    customCss = ''
      /* Personnalisations CSS supplémentaires */
      .Root__top-container {
        padding-top: 0px;
      }
      
      /* Masquer la barre de titre sur Wayland/Linux */
      .Root__top-bar {
        display: none;
      }
      
      /* Améliorer la lisibilité */
      .main-trackList-rowSectionEnd {
        justify-content: flex-end;
      }
    '';
    
    # Paramètres des extensions
    extensionSettings = {
      adblock = {
        # Configuration de l'adblock
        enabled = true;
        aggressive = true;
      };
      
      keyboardShortcut = {
        # Raccourcis personnalisés
        "ctrl+shift+left" = "Previous";
        "ctrl+shift+right" = "Next";
        "ctrl+shift+space" = "PlayPause";
      };
      
      volumePercentage = {
        # Affichage du volume en pourcentage
        enabled = true;
        precision = 0;
      };
    };
  };
  
  # Services additionnels (optionnel)
  services.spotifyd = {
    enable = false;  # Daemon Spotify pour contrôle à distance
    settings = {
      global = {
        username_cmd = "echo $SPOTIFY_USERNAME";
        password_cmd = "echo $SPOTIFY_PASSWORD";
        backend = "pulseaudio";
        device_name = "NixOS Spotify";
        bitrate = 320;
        cache_path = "/tmp/spotifyd";
        initial_volume = "90";
        volume_normalisation = true;
        normalisation_pregain = -10;
      };
    };
  };
}
