{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      # Basic fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf

      # Dev fonts
      fira-code
      fira-code-symbols
      jetbrains-mono

      # Icon fonts
      font-awesome
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "FiraCode Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    posy-cursors
  ];

  # Curseur par défaut pour le système
  environment.variables = {
    XCURSOR_THEME = "Posy_Cursor";
    XCURSOR_SIZE = "24";
  };
}
