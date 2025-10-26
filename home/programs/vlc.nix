{ config, pkgs, ... }:

{
  # Installation de VLC avec support complet
  home.packages = with pkgs; [
    vlc
  ];

  # Configuration optionnelle : associations de fichiers
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Vidéos
      "video/mp4" = "vlc.desktop";
      "video/x-matroska" = "vlc.desktop";
      "video/webm" = "vlc.desktop";
      "video/mpeg" = "vlc.desktop";
      "video/x-msvideo" = "vlc.desktop";

      # Audio
      "audio/mpeg" = "vlc.desktop";
      "audio/flac" = "vlc.desktop";
      "audio/x-wav" = "vlc.desktop";
      "audio/ogg" = "vlc.desktop";
    };
  };
}
