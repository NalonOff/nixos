{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      monitor = ",preferred,auto,1";
      exec-once = [      
      ];
      input = {
        kb_layout = "us";
      };
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
      };
    };

    systemd.variables = ["--all"];
  };

  # Graphical dependences
  home.packages = with pkgs; [
    hyprland
    kitty
    rofi-wayland
    dunst
    networkmanagerapplet
    xdg-desktop-portal-hyprland
    wl-clipboard
    cowsay
  ];

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
  }; 
}


