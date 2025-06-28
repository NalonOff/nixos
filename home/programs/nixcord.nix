{ config, pkgs, inputs, ... }:

{
  # Configuration nixcord
  programs.nixcord = {
    enable = true;
    discord.enable = true;    

    # Plugins de base qui existent vraiment
    config.plugins = {
      fakeNitro.enable = true;       # Emojis gratuits
      messageLogger.enable = true;   # Voir les messages supprimés
      imageZoom.enable = true;       # Zoom sur les images
    }; 
  };
}
