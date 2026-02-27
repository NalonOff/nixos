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
      update = ''f() { cd "$HOME/dotfiles" && nix flake update && sudo nixos-rebuild switch --flake ".#$1"; }; f'';
      rbs = ''f() { sudo nixos-rebuild switch --flake "$HOME/dotfiles/.#$1"; }; f'';
    };

    # Prompt configuration
    initContent = ''pfetch; eval "$(starship init zsh)"'';
   };
}
