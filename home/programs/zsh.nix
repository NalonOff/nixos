{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      ".." = "cd ..";
      "..." = "cd ../..";
      grep = "grep --color=auto";
      
      # NixOS specificatons
      rebuild = "sudo nixos-rebuild switch --flake /home/user/dotfiles";
      update = "cd /home/user/dotfiles && nix flake update && sudo nixos-rebuild switch --flake .";
    };
    
    # Prompt configuration
    initContent = "Welcome to zsh Nalon !";
   };
}
