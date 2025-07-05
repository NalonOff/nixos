# audio.nix - Module de configuration audio pour NixOS/Hyprland
{ config, pkgs, lib, ... }:

{
  # PipeWire comme serveur audio (remplace PulseAudio)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # Configuration WirePlumber (gestionnaire de sessions PipeWire)
    wireplumber.enable = true;
  };

  # Désactiver PulseAudio (incompatible avec PipeWire)
  services.pulseaudio.enable = false;

  # Packages audio utiles
  environment.systemPackages = with pkgs; [
    # Contrôleurs audio
    pavucontrol         # Interface graphique pour PulseAudio/PipeWire
    alsa-utils          # Utilitaires ALSA (amixer, aplay, etc.)

    # Codecs audio
    playerctl          # Contrôle des lecteurs multimédia
  ];

  # Configuration des services audio pour l'environnement utilisateur
  services.pipewire.extraConfig.pipewire = {
    "10-clock-rate" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 2048;
      };
    };
  };

  # Configuration pour une latence audio réduite
  services.pipewire.extraConfig.pipewire-pulse = {
    "92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 32;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 32;
      };
    };
  };

  # Configuration des permissions pour l'audio temps réel
  security.pam.loginLimits = [
    {
      domain = "@audio";
      type = "-";
      item = "rtprio";
      value = "99";
    }
    {
      domain = "@audio";
      type = "-";
      item = "memlock";
      value = "unlimited";
    }
  ];
}

