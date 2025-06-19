{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      # Basic fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      
      # Dev fonts
      fira-code
      fira-code-symbols
      jetbrains-mono
      
      # Icon fonts
      font-awesome
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      #(nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
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
}
