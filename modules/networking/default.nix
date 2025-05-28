{ config, pkgs, ... }:

{
  # NetworkManager
  networking.networkmanager.enable = true;
  
  # Firewall
  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [ 22 80 443 ];
    # allowedUDPPorts = [ ];
  };
  
  # IPv6 support
  networking.enableIPv6 = true;
  
  # DNS resolution
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
}