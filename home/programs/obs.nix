{ config, pkgs, lib, osConfig, ... }:

let
  # Detect if NVIDIA is enabled at system level
  hasNvidia = (osConfig.hardware.nvidia.package or null != null);
in
{
  # OBS Studio installation with plugins for Wayland/Hyprland
  programs.obs-studio = {
    enable = true;
    # CUDA support for NVENC hardware encoding (auto-detected)
    package = if hasNvidia
      then pkgs.obs-studio.override { cudaSupport = true; }
      else pkgs.obs-studio;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs                     # Wayland/wlroots support (essential for Hyprland)
      obs-pipewire-audio-capture # Audio capture via PipeWire
      obs-vaapi                  # VAAPI hardware encoding (AMD/Intel fallback)
      obs-vkcapture              # Vulkan capture
      obs-gstreamer              # GStreamer support
      input-overlay              # Keyboard/mouse display
    ];
  };

  # Environment variables for Wayland
  home.sessionVariables = {
    # Force OBS to use Wayland
    QT_QPA_PLATFORM = "wayland";
    # Better compatibility with Hyprland
    OBS_USE_EGL = "1";
  };
}
