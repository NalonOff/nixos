{ config, pkgs, ... }:

{
  # Essentials system packages
  environment.systemPackages = with pkgs; [
    # Basic tools
    wget
    curl
    git
    vim
    nano
    btop
    tree
    unzip
    zip
    
    # Network tools
    networkmanager
    
    # System tools
    pciutils
    usbutils
    lshw
    
    # IDE
    neovim
  ];
  
  # System environment variables
  environment.variables = {
    EDITOR = "vim";
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
  };

  security.polkit.enable = true;
  programs.dconf.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  #systemd.user.startServices = true;
  #services.dbus.enable = true;
}
