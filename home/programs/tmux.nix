{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    
    extraConfig = ''
      # Raccourcis plus pratiques
      bind | split-window -h
      bind - split-window -v
      
      # Navigation entre les panes avec Alt + flèches
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D
      
      # Redimensionner les panes
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      
      # Améliorer les couleurs
      set -g default-terminal "screen-256color"
      
      # Numérotation des fenêtres à partir de 1
      set -g base-index 1
      set -g pane-base-index 1
      
      # Rechargement automatique des numéros
      set -g renumber-windows on
    '';
  };
}