{ config, pkgs, ... }:

{
  # Essentials system packages
  environment.systemPackages = with pkgs; [
    home-manager

    # Basic tools
    wget
    curl
    git
    btop
    tree
    unzip
    zip

    gcc

    # Network tools
    networkmanager

    # System tools
    pciutils
    usbutils
    lshw
    brightnessctl

    # IDE
    neovim
  ];

  # System environment variables
  environment.variables = {
    EDITOR = "neovim";
  };

  # Essential services
  services = {
    # SSH (optionnel, décommentez si nécessaire)
    # openssh = {
    #   enable = true;
    #   settings.PasswordAuthentication = false;
    # };

    # Cron
    cron.enable = true;

    # Bluetooth
    blueman.enable = true;
  };

  # Default shell configuration
  programs = {
    zsh.enable = true;
    bash.completion.enable = true;

    # Steam configuration au niveau système
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    # GameMode pour les performances
    gamemode.enable = true;
  };

  security.polkit.enable = true;
  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland  # Portal optimisé pour Hyprland
      xdg-desktop-portal-gtk       # Fallback pour apps GTK
    ];
    config = {
      common = {
        default = ["hyprland" "gtk"];
      };
      hyprland = {
        default = ["hyprland" "gtk"];
      };
    };
  };

  # Configuration graphique avec support 32-bit pour Steam
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # Support 32-bit pour Steam
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Support Steam hardware (contrôleurs, etc.)
  hardware.steam-hardware.enable = true;
}
