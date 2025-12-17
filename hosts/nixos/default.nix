{ config, pkgs, inputs, settings, ... }:

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
    #../../modules/graphics/amd.nix
    ../../modules/graphics/nvidia.nix
    ../../modules/docker
  ];

  # System version
  system.stateVersion = "25.05";

  # Host name
  networking.hostName = "nixos";

  # Time zone
  time.timeZone = settings.system.timezone;

  # Location
  i18n.defaultLocale = settings.system.locale;
  console.keyMap = settings.system.keyboard;

  # Flakes and nix commande
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

  nixpkgs.config.allowUnfree = true;
}
