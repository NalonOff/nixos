{ config, pkgs, ... }:

{
  # Packages for waybar
  home.packages = with pkgs; [
    # Apps use by waybar
    swaynotificationcenter
    blueman
    pamixer
    pavucontrol
    networkmanagerapplet
    playerctl  # for MPRIS
 ];

  # Services configuration
  services.swaync.enable = true;

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        mod = "dock";
        exclusive = true;
        "gtk-layer-shell" = true;
        "margin-top" = 6;
        "margin-bottom" = 0;
        passthrough = false;
        height = 0;

        "modules-left" = [ "group/leftSide" ];
        "modules-center" = [ "hyprland/workspaces" ];
        "modules-right" = [ "tray" "group/rightSide" "custom/swaync" ];

        # Language
        "hyprland/language" = {
          format = "{}";
          format-en = "ENG";
          format-fr = "FR";
        };

        "custom/os_button" = {
          format = "<span font='18'> </span>";
          tooltip = false;
          on-click = "${pkgs.rofi}/bin/rofi -show drun";
        };

        # Media
        mpris = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} {dynamic}";
          player-icons = {
            default = "";
            spotify = "󰓇 ";
            firefox = "󰈹 ";
            vlc = "󰕼 ";
          };
          status-icons = {
            paused = "󰏤";
            playing = "󰐊";
            stopped = "󰓛";
          };
          dynamic-order = ["title" "artist"];
          dynamic-separator = " - ";
          #dynamic-len = 40;
          tooltip-format = "{player}: {dynamic}";
          tooltip = true;
          on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
          on-click-right = "${pkgs.playerctl}/bin/playerctl next";
          on-scroll-up = "${pkgs.playerctl}/bin/playerctl previous";
          on-scroll-down = "${pkgs.playerctl}/bin/playerctl next";
        };

        # Network
        network = {
          format-wifi = "{icon}";
          format-ethernet = "󰈀 ";
          format-disconnected = "󰌙 ";
          tooltip-format = "{icon} {essid}";
          format-icons = [ "󰤯 " "󰤟 " "󰤢 " "󰤥 " "󰤨 " ];
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };

        # Bluetooth
        bluetooth = {
          format = "";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "${pkgs.blueman}/bin/blueman-manager";
        };

        # Battery
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon}";
          #tooltip-format = "{icon} {capacity}%";
          format-charging = "󰂄";
          format-plugged = "󰚥";
          format-icons = [ "󱊡" "󱊢" "󱊣" ];
          tooltip-format = "{capacity}% • {time} • {power}W";
          interval = 5;
        };


        # Audio
        pulseaudio = {
          max-volume = 150;
          scroll-step = 10;
          format = "{icon}";
          tooltip-format = "{icon} {volume}%";
          format-icons = {
            headphone = "󰋋";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          format-muted = "󰝟 ";
          on-click = "${pkgs.pamixer}/bin/pamixer -t";
          on-click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        # Brightness
        backlight = {
          device = "intel_backlight";
          format = "{icon}";
          tooltip-format = "{icon} {percent}%";
          format-icons = [ " " " " " " " " " " " " " " " " " " ];
        };

        # Notifications
        "custom/swaync" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='#7b82c6'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          #exec-if = "which swaync-client";
          #exec = "${pkgs.swaync}/bin/swaync-client -swb";
          #on-click = "${pkgs.swaync}/bin/swaync-client -t -sw";
          #on-click-right = "${pkgs.swaync}/bin/swaync-client -d -sw";
          escape = true;
        };

        # Hyprland's workspaces
        "hyprland/workspaces" = {
          format = "{icon}";
          icon-size = 32;
          spacing = 16;
          on-scroll-up = "${pkgs.hyprland}/bin/hyprctl dispatch workspace r+1";
          on-scroll-down = "${pkgs.hyprland}/bin/hyprctl dispatch workspace r-1";
          persistent-workspaces = {
            "*" = 4;
          };
          format-icons = {
            urgent = "";
            sort-by-number = true;
          };
        };

        # Taskbar
        "wlr/taskbar" = {
          format = "{icon} {title:.18}";
          icon-size = 18;
          spacing = 3;
          on-click-middle = "close";
          tooltip-format = "{title}";
          ignore-list = [];
          on-click = "activate";
        };

        # System tray
        tray = {
          icon-size = 18;
          spacing = 8;
        };

        # Clock
        clock = {
          format = " {:%R}";
          tooltip-format = " {:%d %B %Y}";
        };

        # Memory
        memory = {
          format = " {}%";
          format-alt = " {used}/{total} GiB";
          interval = 5;
        };

        # CPU
        cpu = {
          format = " {usage}%";
          format-alt = "  {avg_frequency} GHz";
          interval = 5;
        };

        # Groups
        "group/hardware" = {
          orientation = "horizontal";
          modules = [ "memory" "cpu" ];
        };

        "group/controlCenter" = {
          orientation = "horizontal";
          modules = [ "pulseaudio" "network" "battery" ];
        };

        "group/leftSide" = {
          orientation = "horizontal";
          modules = [ "custom/os_button" "group/hardware" "mpris" ];
        };

        "group/rightSide" = {
          orientation = "horizontal";
          modules = [ "group/controlCenter" "clock" ];
        };
      };
    };

    # Style CSS
    style = ''
      * {
        all: unset;
        font-family: "JetBrainsMono Nerd Font","Fira Mono";
        font-weight: 700;
        font-size: 12.5px;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
      }

      window#waybar {
        background: rgba(4, 5, 7, 0);
        color: @base05;
      }

      tooltip {
        background: @base01;
        border-radius: 5px;
        border-width: 1px;
        border-style: solid;
        border-color: @base03;
      }
      tooltip label {
        color: @base05;
      }

      /* Custom widget for sway notifications */
      #custom-swaync {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 1px;
        color: @base05;
        background-color: @base01;
        min-width: 20px;
        padding-left: 12px;
        padding-right: 12px;
        margin-left: 10px;
        margin-right: 5px;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
        border: 2px solid @base03;
        border-radius: 10px;
      }

      /* Workspaces styling */
      #workspaces {
        color: transparent;
        margin-right: 1.5px;
        margin-left: 1.5px;
        border-radius: 12px;
        border: 2px solid @base03;
        background-color: @base00;
        padding: 0px 20px;
      }
      #workspaces button {
        color: @base05;
        transition: all 0.25s ease-out;
        padding: 2px 10px;
        margin: 3px 4px;
        background-color: @base01;
        border-radius: 10px;
        border-color: @base03;
      }

      #workspaces button.active {
        color: @base04;
        border-radius: 8px;
        background: @base02;
        padding: 0px 20px;
      }
      #workspaces button.focused {
        color: @base04;
      }
      #workspaces button.urgent {
        background: @base09;
        border-bottom: 0px dashed @base08;
        color: @base08;
      }
      #workspaces button:hover {
        background: @base0D;
        color: @base01;
      }

      /* Styling for system info panels like CPU, Disk, Memory */
      #cpu, #disk, #memory {
        padding: 3px;
      }

      /* Window styling */
      #window {
        border-radius: 10px;
        margin-left: 20px;
        margin-right: 20px;
      }

      /* Tray panel styling */
      #tray {
        margin-left: 5px;
        margin-right: 5px;
        border: 2px solid @base03;
        border-radius: 10px;
        padding: 0px 10px;
        margin-right: 20px;
        background-color: @base00;
      }

      #tray > .passive {
        border-bottom: none;
      }

      #tray > widget {
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
        border-radius: 8px;
        padding: 0px 3px;
      }

      #tray menu, menu {
        font-family: "JetBrainsMono Nerd Font";
        border: 2px solid @base03;
        border-radius: 10px;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
        background-color: @base00;
        padding: 5px 2px;
      }

      #tray menu > *, menu > * {
        color: @base05;
        border: 2px solid transparent;
        border-radius: 10px;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
        padding: 0px 8px;
      }

      #tray menu > *:hover, menu > *:hover {
        border: 2px solid @base0D;
        background-color: @base01;
        border: 2px solid transparent;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
        border-bottom: 2px solid @base0D;
      }

      #tray menu > *:active, menu > *:active {
        background-color: @base01;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
      }

      /* Language widget styling */
      #language {
        background-color: @base00;
        padding-left: 5px;
        padding-right: 5px;
        border: 2px solid @base05;
        border-left: 0px;
        border-right: 0px;
        border-radius: 0px;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
      }

      /* Bluetooth widget styling */
      #bluetooth {
        padding: 0px 10px;
        font-size: 14px;
        font-family: "Fira Code";
      }

      /* Bluetooth widget status colors */
      #bluetooth.disabled, #bluetooth.off {
        color: @base03;
      }
      #bluetooth.on, #bluetooth.connected {
        color: @base0D;
      }

      /* Sway notification custom widget and other widgets */
      #custom-swaync {
        font-size: 20px;
        padding: 0px 8px;
        padding-right: 13px;
      }

      /* Styling for memory, search, os button, etc. */
      #cpu, #memory, #custom-search, #custom-os_button, #custom-runner, #mpris, #custom-cafein, #cava, #clock {
        font-family: "Symbols Nerd Font", "JetbrainsMono Nerd Font";
        background-color: @base00;
        font-weight: bold;
        border-radius: 16px;
        padding: 0px 10px;
        border: 0px solid @base05;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
      }

      #mpris {
        padding: 0px 8px;
        margin: 0px 8px;
        min-width: 200px;
      }

      /* Hover effect for bar elements */
      #custom-swaync:hover,#tray > widget:hover,#custom-search:hover, #custom-os_button:hover, #custom-runner:hover, #mpris:hover, #clock:hover, #hardware:hover{
        background-color: @base01;
      }

      /* Hardware widget styling */
      #hardware {
        background-color: @base00;
        font-weight: bold;
        padding: 0px 10px;
        margin: 2px 0px;
        border-radius: 10px;
      }

      #cpu, #memory {
        background-color: unset;
      }

      /* Bluetooth, network, pulseaudio icon size adjustment */
      #bluetooth {
        font-size: 15px;
      }

      #leftSide {
        border: 2px solid @base05;
        border-radius: 10px;
        margin: 0px 10px;
        background-color: @base00;
        padding: 0px 10px;
      }

      /* Right Side */
      #rightSide {
        border: 2px solid @base05;
        border-radius: 10px;
        margin: 0px 10px;
        background-color: @base00;
        padding: 0px 10px;
        padding-left: 2px;
      }

      #clock {
        font-size: 14px;
        padding: 0px 6px;
        margin: 0px 4px;
      }

      /* Control Center*/
      #controlCenter {
        background-color: @base00;
        border-radius: 15px;
        padding: 0px 8px;
        margin: 0px 10px;
      }

      #controlCenter:hover {
        background-color: @base01;
      }

      #network, #pulseaudio, #battery, #backlight {
      padding: 0px 6px;
        font-size: 15px;
      }
    '';
  };
}
