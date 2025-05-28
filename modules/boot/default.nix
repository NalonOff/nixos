{ config, pkgs, ... }:

{
  # Configuration du bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  
  # Kernel par défaut
  boot.kernelPackages = pkgs.linuxPackages;
  
  # Support des systèmes de fichiers
  boot.supportedFilesystems = [ "ntfs" ];
}