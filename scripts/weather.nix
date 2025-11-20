{ config, pkgs, settings, ... }:

{
  # Weather script at ~/.scripts/weather.sh
  home.file.".scripts/weather.sh" = {
    text = ''
      #!/usr/bin/env bash

      # Configuration from settings
      CITY="${settings.user.city}"
      COUNTRY="${settings.user.country}"

      # Check if variables are defined
      if [[ -z "$CITY" || -z "$COUNTRY" ]]; then
          echo "Error: City or country not defined"
          exit 1
      fi

      # Fetch weather data
      weather_info=$(curl -s --fail "https://wttr.in/$CITY?format=%c+%t" 2>/dev/null)

      # Check if request succeeded
      if [[ $? -ne 0 || -z "$weather_info" ]]; then
          echo ""
          exit 1
      fi

      # Display result
      echo "$weather_info"
    '';
    executable = true;
  };
}
