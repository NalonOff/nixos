{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    vlc
  ];

  # Optional configuration
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Videos
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
