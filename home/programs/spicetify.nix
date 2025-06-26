{ config, pkgs, lib, ... }:

{
  # Installation de Spotify
  home.packages = with pkgs; [
    spotify
  ];

  # Configuration complète de Spicetify
  programs.spicetify = {
    enable = true;
    
    # Thème principal
    theme = pkgs.spicetify-cli.themes.catppuccin-mocha;
    
    # Extensions populaires
    enabledExtensions = with pkgs.spicetify-cli.extensions; [
      adblock           # Bloque les pubs
      hidePodcasts      # Cache la section podcasts
      shuffle           # Améliore le shuffle
      keyboardShortcut  # Raccourcis clavier personnalisés
      fullAppDisplay    # Affichage plein écran amélioré
      history           # Historique d'écoute
      powerBar          # Barre de contrôle avancée
      volumePercentage  # Affiche le pourcentage du volume
    ];
    
    # Applications personnalisées (optionnel)
    enabledCustomApps = with pkgs.spicetify-cli.apps; [
      lyrics-plus       # App paroles avancée
      new-releases      # Nouvelles sorties
    ];
  };
}
