{ config, pkgs, ... }:

{
  # Installation d'OBS Studio avec plugins pour Wayland/Hyprland
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs                     # Support Wayland/wlroots (essentiel pour Hyprland)
      obs-pipewire-audio-capture # Capture audio via PipeWire
      obs-vaapi                  # Encodage matériel VAAPI
      obs-vkcapture              # Capture Vulkan
      obs-gstreamer              # Support GStreamer
      input-overlay              # Affichage des touches/souris
    ];
  };

  # Variables d'environnement pour Wayland
  home.sessionVariables = {
    # Force OBS à utiliser Wayland
    QT_QPA_PLATFORM = "wayland";
    # Meilleure compatibilité avec Hyprland
    OBS_USE_EGL = "1";
  };

  # Configuration de base pour les profils
  xdg.configFile."obs-studio/basic/profiles/Hyprland/basic.ini".text = ''
    [General]
    Name=Hyprland

    [Video]
    BaseCX=1920
    BaseCY=1080
    OutputCX=1920
    OutputCY=1080
    FPSType=0
    FPSCommon=60

    [Audio]
    SampleRate=48000
    ChannelSetup=Stereo

    [Output]
    Mode=Advanced

    [AdvOut]
    RecType=Standard
    RecFormat=mkv
    RecEncoder=obs_x264
    RecQuality=Stream
  '';
}
