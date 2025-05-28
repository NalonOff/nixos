{ config, pkgs, unstable, ... }:

{
  imports = [
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/hyprland.nix
  ];

  # User informations
  home = {
    username = "nalon";
    homeDirectory = "/home/nalon";
    stateVersion = "25.05";
  };
  
  # User packages
  home.packages = with pkgs; [
    # CLI tools
    tree
    fd
    ripgrep
    bat
    eza
    fzf
    jq
    
    # Network tools
    wget
    curl
    
    # Basic dev
    nodejs
    python3
    
    # Other tools
    neofetch
    btop
    du-dust
  ];
  
  # Environment variables
  home.sessionVariables = {
    EDITOR = "vim";
    PAGER = "less";
  };
  
  # Home Manager manage itself
  programs.home-manager.enable = true;

  systemd.user.startServices = true;
}
