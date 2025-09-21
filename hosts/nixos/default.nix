{ config, pkgs, inputs, unstable, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/boot
    ../../modules/greet
    ../../modules/networking
    ../../modules/users
    ../../modules/system
    ../../modules/fonts
    ../../modules/ssh
    ../../modules/audio
    ../../modules/graphics/amd.nix
    #../../modules/graphics/nvidia.nix
  ];

  # Version du système
  system.stateVersion = "25.05";

  # Nom d'hôte
  networking.hostName = "nixos";

  # Fuseau horaire
  time.timeZone = "Europe/Paris";

  # Localisation
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "fr";

  # Flakes et commande nix
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  boot.kernelParams = [ "rtw_8821ce.fwctrl_lps=0" "rtw_8821ce.swlps=0" ];
  hardware.enableAllFirmware = true;

  # Logiciels propriétaires
  nixpkgs.config.allowUnfree = true;
}
