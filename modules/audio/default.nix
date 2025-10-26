{ config, lib, pkgs, ... }:

{
  # Completely disable PulseAudio to avoid conflicts
  services.pulseaudio.enable = false;

  # Security configuration for real-time audio
  security.rtkit.enable = true;

  # PipeWire configuration
  services.pipewire = {
    enable = true;

    # Enable compatibility layers
    alsa.enable = true;
    alsa.support32Bit = true;  # 32-bit support for certain applications
    pulse.enable = true;       # PulseAudio compatibility layer
    jack.enable = true;        # JACK support for professional audio

    # Advanced PipeWire configuration
    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate = 48000;
        default.clock.quantum = 32;
        default.clock.min-quantum = 32;
        default.clock.max-quantum = 32;
      };
    };

    # Configuration for WirePlumber (PipeWire session manager)
    wireplumber.enable = true;

    # Specific configuration to avoid issues with Waybar
    extraConfig.pipewire-pulse."92-pulse-config" = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse.min.req = "32/48000";
            pulse.default.req = "32/48000";
            pulse.max.req = "32/48000";
            pulse.min.quantum = "32/48000";
            pulse.max.quantum = "32/48000";
            server.address = [ "unix:native" ];
          };
        }
      ];
      stream.properties = {
        node.latency = "32/48000";
        resample.quality = 1;
      };
    };
  };

  # Useful audio packages
  environment.systemPackages = with pkgs; [
    # Audio control utilities
    pavucontrol          # Graphical interface for audio control
    pulsemixer           # Command-line audio mixer
    pamixer              # Command-line volume control

    # PipeWire utilities
    pipewire             # The main audio server
    wireplumber          # Session manager
    helvum               # Graphical interface for PipeWire (optional)

    # Audio codecs
    pulseaudio           # For command-line tools (pactl, etc.)
  ];

  # Environment variables to ensure compatibility
  environment.sessionVariables = {
    # Force the use of PulseAudio server via PipeWire
    PULSE_SERVER = "unix:\${XDG_RUNTIME_DIR}/pulse/native";
  };

  # User services for PipeWire
  systemd.user.services = {
    pipewire-pulse.wantedBy = [ "default.target" ];
  };

  # Note: The 'audio' group is generally no longer necessary with PipeWire
  # Manually add your user to the audio group in your configuration.nix if needed:
  # users.users.your-username.extraGroups = [ "audio" ];

  # Kernel parameters for audio
  boot.kernelModules = [ "snd-aloop" ];  # Module for virtual audio devices

  # Udev configuration for audio permissions
  services.udev.extraRules = ''
    # Permissions for audio devices
    SUBSYSTEM=="sound", GROUP="audio", MODE="0664"
    KERNEL=="controlC[0-9]*", GROUP="audio", MODE="0664"
  '';
}
