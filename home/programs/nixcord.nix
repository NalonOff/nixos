{ config, pkgs, inputs, ... }:

{
  # Nixcord configuration
  programs.nixcord = {
    enable = true;
    discord.enable = true;

    # Default plugins
    config.plugins = {
      fakeNitro.enable = true;       # Free emojis
      messageLogger.enable = true;   # See deleted messages
      imageZoom.enable = true;       # Zoom on images
    };
  };
}
