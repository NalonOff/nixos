{ config, pkgs, unstable, ... }:

{
  imports = [
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/hyprland.nix
    ./programs/kitty.nix
    ./programs/pfetch.nix
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
    
    # Apps
    chromium

    # Ricing
    starship

    # Network tools
    wget
    curl
    
    # Basic dev
    nodejs
    python3
    
    # Other tools
    pfetch
    btop
    du-dust
  ];
  
  # Environment variables
  home.sessionVariables = {
    EDITOR = "neovim";
    PAGER = "less";
  };
  
  # Home Manager manage itself
  programs.home-manager.enable = true;

  systemd.user.startServices = true;
}
