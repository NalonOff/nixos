{ config, lib, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;

    settings = {
      # Variables
      "$CITY" = "Tarbes";
      "$COUNTRY" = "FRANCE";
      "$WALLPAPER_PATH" = "~/dotfiles/home/wallpapers/original/astronaut.png";

      # BACKGROUND
      background = lib.mkForce {
        path = "$WALLPAPER_PATH";
        blur_passes = 3;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      # GENERAL
      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = false;
      };

      # INPUT FIELD
      input-field = lib.mkForce [
        {
          monitor = "";
          size = "170, 45";
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(100, 114, 125, 0.4)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = true;
          font_family = "SF Pro Text Semibold";
          placeholder_text = "<span foreground=\"#🔒 #ffffff99\">Enter Password</span>";
          hide_input = false;
          position = "0, -400";
          halign = "center";
          valign = "center";
        }
      ];

      # LABELS
      label = [
        # TIME
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<span>$(date +\"%H:%M\")</span>\"";
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 100;
          font_family = "SF Pro Display Bold";
          position = "0, 400";
          halign = "center";
          valign = "center";
        }

        # DAY-MONTH-DATE
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%A, %B %d\")\"";
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 20;
          font_family = "SF Pro Display Semibold";
          position = "0, 310";
          halign = "center";
          valign = "center";
        }

        # USER
        {
          monitor = "";
          text = "$USER";
          color = "rgba(216, 222, 233, 0.7)";
          font_size = 20;
          font_family = "SF Pro Text Semibold";
          position = "0, -335";
          halign = "center";
          valign = "center";
        }

        # CURRENT SONG (SPOTIFY)
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(sh ~/dotfiles/scripts/media-player.sh)\"";
          color = "rgba(255, 255, 255, 0.7)";
          font_size = 18;
          font_family = "SF Pro Display Semibold";
          position = "100, 0";
          halign = "left";
          valign = "center";
        }

        # WEATHERCAST & LOCATION
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(sh ~/dotfiles/scripts/weather.sh)\"";
          color = "rgba(255, 255, 255, 0.7)";
          font_size = 18;
          font_family = "SF Pro Display Semibold";
          position = "95.5, -40";
          halign = "left";
          valign = "center";
        }
      ];

      # PROFILE-PHOTO
      image = [
        {
          monitor = "";
          path = "/home/nalon/dotfiles/home/wallpapers/original/astronaut.png";
          border_color = "0xffdddddd";
          border_size = 0;
          size = 110;
          rounding = 55;
          rotate = 0;
          reload_time = -1;
          reload_cmd = "";
          position = "0, -240";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
