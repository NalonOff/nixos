{ config, pkgs, settings, ... }:

{
  # Media player script at ~/.scripts/media-player.sh
  home.file.".scripts/media-player.sh" = {
    text = ''
      #!/usr/bin/env bash

      # Get current playing song from playerctl
      if command -v playerctl &> /dev/null; then
        artist=$(playerctl metadata artist 2>/dev/null)
        title=$(playerctl metadata title 2>/dev/null)

        if [[ -n "$artist" && -n "$title" ]]; then
          echo "$artist - $title"
        else
          echo "No music playing"
        fi
      else
        echo ""
      fi
    '';
    executable = true;
  };
}
