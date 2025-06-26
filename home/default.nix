{ config, pkgs, unstable, ... }:

{
  imports = [
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/hyprland.nix
    ./programs/kitty.nix
    ./programs/pfetch.nix
    ./programs/mozilla.nix
    ./programs/discord.nix
    #./programs/spicetify.nix
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
    rofi
    nautilus

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
    
    # Electron / Ozone
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    OZONE_PLATFORM = "wayland";

    # Qt / GTK scaling & Wayland support
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    GTK_USE_PORTAL = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # Session & compatibility
    XDG_SESSION_TYPE = "wayland";

    EDITOR = "neovim";
    PAGER = "less";
  };
  
  # Home Manager manage itself
  programs.home-manager.enable = true;

  systemd.user.startServices = true;
}
