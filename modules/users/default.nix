{ config, pkgs, ... }:

{
  # Main user
  users.users.nalon = {
    isNormalUser = true;
    description = "Main user";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  
  # Enable zsh
  programs.zsh.enable = true;
  
  # Sudo configuration
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };
}
