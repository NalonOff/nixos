{ config, pkgs, ... }:

{
  # Packages Steam et gaming pour Home Manager
  home.packages = with pkgs; [
    steam
    steam-run
    steamcmd
    
    # Outils gaming supplémentaires
    gamemode
    mangohud
    
    # Support Proton/Wine
    wineWowPackages.stable
    winetricks
  ];

  # Variables d'environnement pour le gaming
  home.sessionVariables = {
    # Steam scaling pour Wayland
    STEAM_FORCE_DESKTOPUI_SCALING = "1";
    
    # Variables pour les performances gaming
    __GL_THREADED_OPTIMIZATIONS = "1";
    __GL_SHADER_DISK_CACHE = "1";
    
    # GameMode
    LD_PRELOAD = "${pkgs.gamemode}/lib/libgamemode.so.0";
  };
}
