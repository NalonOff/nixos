{ config, pkgs, ... }:

{
  # Steam and gaming packages for Home Manager
  home.packages = with pkgs; [
    steam
    steam-run
    steamcmd

    # More tools
    mangohud

    # Proton/Wine support
    wineWowPackages.stable
    winetricks
  ];

  # Environment variables for gaming
  home.sessionVariables = {
    # Steam scaling for Wayland
    STEAM_FORCE_DESKTOPUI_SCALING = "1";

    # Variables for gaming performances
    __GL_THREADED_OPTIMIZATIONS = "1";
    __GL_SHADER_DISK_CACHE = "1";
  };
}
