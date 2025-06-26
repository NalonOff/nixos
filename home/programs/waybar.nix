{ config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        margin-top = 10;
        margin-bottom = 0;
        margin-right = 10;
        margin-left = 10;

        modules-left = [
          "custom/start"
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [
          "clock"
          "hyprland/submap"
          "tray"
        ];
        modules-right = [
          "temperature"
          "cpu"
          "memory"
          "disk"
          "pulseaudio"
          "network"
          "battery"
          # "power-profiles-daemon"
        ];
        "cpu" = {
          states = {
            critical = 85;
          };
          interval = 1;
          format = " {usage:2}%";
          on-click = "kitty btop";
        };
        "memory" = {
          states = {
            critical = 85;
          };
          interval = 1;
          format = " {used:0.1f}GiB";
          on-click = "kitty btop";
        };
        "disk" = {
          states = {
            critical = 85;
          };
          interval = 5;
          format = " {used}";
          on-click = "kitty btop";
        };
        "network" = {
          interval = 1;
          format-ethernet = " {ifname}";
          format-wifi = " {signalStrength}%";
          format-disconnected = "";
          format-disabled = "";
          tooltip = false;
          on-click = "rofi-network-manager";
        };
        "temperature" = {
          hwmon-path =  "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          format = " {temperatureC}°C";
          interval = 1;
          on-click = "kitty btop";
        };
        "power-profiles-daemon" = {
          format = "{icon} {profile}";
          format-icons = {
            performance = "";
            power-saver = "";
            balanced = "";
          };
        };
        "hyprland/workspaces" = {
          format = "{name}";
          format-icons = {
            default = " ";
            active = " ";
            urgent = " ";
          };
          on-scroll-down = "hyprctl dispatch workspace e+1";
          on-scroll-up = "hyprctl dispatch workspace e-1";
        };
        "hyprland/window" = {
          icon = true;
          max-length = 55;
          separate-outputs = false;
          rewrite = {
            "" = "nalon@nixos";
            "~" = "nalon@$nixos";
          };
          on-click-right = "hyprctl dispatch fullscreen 0";
          on-click-middle = "hyprctl dispatch killactive";
          on-click = "hyprctl dispatch fullscreen 1";
        };
        "hyprland/submap" = {
          format = " {}";
          on-click = "hyprctl dispatch submap reset";
        };
        "clock" = {
          format = "{:%b %d, %I:%M %p}";
          on-click = "gnome-clocks";
        };
        "tray" = {
          spacing = 12;
        };
        "taskbar" = {
          icon-size = 10;
          icon-theme = "Papirus-Dark";
          on-click = "activate";
          on-click-right = "fullscreen";
          on-click-middle = "close";
          on-scroll-up = "maximize";
          on-scroll-down = "minimize";
        };
        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {volume}% {format_source_muted}";
          format-muted = " {volume}% {format_source_muted}";
          format-source = "";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
          on-click-middle = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          interval = 1;
          on-click = "";
        };
        "custom/start" = {
          format = "";
          on-click-middle = "hyprctl dispatch togglespecialworkspace hidden";
          on-click-right = "rofi -show power-menu -modi power-menu:rofi-power-menu";
          on-click = "rofi -show drun -show-icons -display-drun ''";
        };
      }
    ];
    style = ''
      * {
        font-size: 12px;
        font-family: Font Awesome, monospace;
        font-weight: bold;
        color: #cdd6f4;
        transition: none;
        transition: all, 0.25s ease-out;
      }

      window#waybar, .modules-left, .modules-center, .modules-right { border-radius: 10px; }
      .modules-left, .modules-center, .modules-right { padding: 0 5px; }
      window#waybar.solo, window#waybar.fullscreen, .modules-left, .modules-center, .modules-right {
        background-color: #11111b;
        border: 2px solid #313244;
      }
      window#waybar.solo .modules-right, window#waybar.solo .modules-center,
      window#waybar.fullscreen .modules-right, window#waybar.fullscreen .modules-center {
        border-left: none;
      }
      window#waybar.solo .modules-left, window#waybar.solo .modules-center,
      window#waybar.fullscreen .modules-left, window#waybar.fullscreen .modules-center {
        border-right: none;
      }
      window#waybar.solo .modules-center, window#waybar.fullscreen .modules-center {
        border-radius: 0px;
      }
      window#waybar.solo .modules-left, window#waybar.fullscreen .modules-left {
        border-radius: 10px 0px 0px 10px;
      }
      window#waybar.solo .modules-right, window#waybar.fullscreen .modules-right {
         border-radius: 0px 10px 10px 0px;
      }
      window#waybar {
        background: rgba(0,0,0,0);
        border: 2px solid transparent;
      }

      #window, #submap { padding: 0px 5px; }
      #submap, #workspaces, #cpu, #memory, #disk, #clock, #window, #tray, #pulseaudio, #battery, #network, #temperature, #power-profiles-daemon, #custom-exit, #custom-start { padding: 0px 5px; margin: 0px 5px; }

      #workspaces button {
        border-radius: 0px;
        margin: 0px;
        background: none;
        border: none;
      }

      #workspaces button:hover, #custom-start:hover, #window:hover {
        border: none;
        outline: none;
        background: none;
        color: #cdd6f4;
        background-size: 300% 300%;
        background: #1e1e2e;
      }

      #workspaces button.active, #submap {
        background: #313244;
      }

      #custom-start {
        padding: 0px 5px;
        color: #313244;
        font-size: 16px;
      }

      .critical, .muted, .performance { color: #f38ba8; }
      .warning, .urgent, .disabled, .disconnected { color: #f9e2af; }
      .charging, .plugged, .power-saver { color: #a6e3a1; } 
    '';
  };
}
