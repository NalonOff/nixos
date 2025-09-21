{ config, pkgs, ... }:

{
  imports = [
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/hyprland.nix
    ./programs/hyprlock.nix
    ./programs/kitty.nix
    ./programs/pfetch.nix
    ./programs/firefox.nix
    ./programs/nixcord.nix
    ./programs/waybar.nix
    ./programs/spicetify.nix
    ./programs/steam.nix
    ./programs/nixvim.nix
    ./programs/stylix.nix
    #./programs/rofi.nix
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
    nautilus

    # Ricing
    starship
    swww

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
