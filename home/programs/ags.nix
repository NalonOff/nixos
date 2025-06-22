{ config, lib, pkgs, ... }:

{
  # Installation d'AGS via Home Manager
  home.packages = with pkgs; [
    ags
  ];

  # Configuration des fichiers AGS
  home.file = {
    # Configuration principale AGS
    ".config/ags/config.js".text = ''
      import { App } from "resource:///com/github/Aylur/ags/app.js";
      import { Widget } from "resource:///com/github/Aylur/ags/widget.js";
      import { Applications } from "resource:///com/github/Aylur/ags/service/applications.js";
      import { Utils } from "resource:///com/github/Aylur/ags/utils.js";

      // Fonction pour créer l'entrée d'application
      const AppItem = (app) => Widget.Button({
        className: "app-item",
        onClicked: () => {
          App.closeWindow("launcher");
          app.launch();
        },
        child: Widget.Box({
          children: [
            Widget.Icon({
              icon: app.iconName || "",
              size: 42,
            }),
            Widget.Label({
              className: "app-name",
              label: app.name,
              xalign: 0,
              vpack: "center",
              truncate: "end",
            }),
          ],
        }),
      });

      // Liste des applications
      const AppsList = () => {
        const list = Widget.Box({
          vertical: true,
          children: Applications.query("").map(AppItem),
        });

        const scrollable = Widget.Scrollable({
          hscroll: "never",
          css: "min-height: 400px;",
          child: list,
        });

        return scrollable;
      };

      // Barre de recherche
      const SearchEntry = () => {
        const entry = Widget.Entry({
          hexpand: true,
          className: "search-entry",
          placeholderText: "Rechercher une application...",
          onAccept: () => {
            const results = Applications.query(entry.text || "");
            if (results[0]) {
              App.closeWindow("launcher");
              results[0].launch();
            }
          },
          onChange: ({ text }) => {
            list.children = Applications.query(text || "").map(AppItem);
          },
        });

        return entry;
      };

      // Fenêtre principale du launcher
      const LauncherWindow = () => Widget.Window({
        name: "launcher",
        className: "launcher-window",
        setup: self => self.keybind("Escape", () => {
          App.closeWindow("launcher");
        }),
        visible: false,
        keymode: "exclusive",
        child: Widget.Box({
          vertical: true,
          className: "launcher-box",
          children: [
            Widget.Box({
              className: "search-box",
              children: [SearchEntry()],
            }),
            AppsList(),
          ],
        }),
      });

      // Configuration de l'application
      App.config({
        style: "./style.css",
        windows: [
          LauncherWindow(),
        ],
      });
    '';

    # Fichier CSS pour le style
    ".config/ags/style.css".text = ''
      * {
        all: unset;
        #font-family: "Inter", sans-serif;
      }

      .launcher-window {
        background-color: rgba(0, 0, 0, 0.8);
      }

      .launcher-box {
        background-color: #1e1e2e;
        border-radius: 12px;
        padding: 20px;
        margin: 100px;
        min-width: 600px;
        max-width: 800px;
        border: 2px solid #313244;
      }

      .search-box {
        margin-bottom: 20px;
      }

      .search-entry {
        background-color: #313244;
        border-radius: 8px;
        padding: 12px 16px;
        font-size: 16px;
        color: #cdd6f4;
        border: 2px solid #45475a;
      }

      .search-entry:focus {
        border-color: #89b4fa;
        box-shadow: 0 0 0 2px rgba(137, 180, 250, 0.2);
      }

      .app-item {
        padding: 12px 16px;
        margin: 4px 0;
        border-radius: 8px;
        background-color: transparent;
        transition: all 200ms ease;
      }

      .app-item:hover {
        background-color: #313244;
        transform: translateX(4px);
      }

      .app-item:active {
        background-color: #45475a;
      }

      .app-item box {
        spacing: 16px;
      }

      .app-name {
        font-size: 14px;
        font-weight: 500;
        color: #cdd6f4;
      }

      scrollbar {
        width: 8px;
      }

      scrollbar trough {
        background-color: #313244;
        border-radius: 4px;
      }

      scrollbar thumb {
        background-color: #585b70;
        border-radius: 4px;
      }

      scrollbar thumb:hover {
        background-color: #6c7086;
      }
    '';

    # Script de lancement optionnel
    ".config/ags/launch.sh" = {
      text = ''
        #!/usr/bin/env bash
        
        # Tue AGS s'il est déjà en cours d'exécution
        pkill ags
        
        # Lance AGS
        ags &
        
        # Fonction pour toggle le launcher
        toggle_launcher() {
          if ags -r "App.getWindow('launcher').visible"; then
            ags -r "App.closeWindow('launcher')"
          else
            ags -r "App.openWindow('launcher')"
          fi
        }
        
        # Si l'argument 'toggle' est passé, toggle le launcher
        if [ "$1" = "toggle" ]; then
          toggle_launcher
        fi
      '';
      executable = true;
    };
  };

  # Service systemd pour lancer AGS automatiquement
  systemd.user.services.ags = {
    Unit = {
      Description = "AGS (Astal GTK Shell)";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.ags}/bin/ags";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # Variables d'environnement si nécessaire
  home.sessionVariables = {
    AGS_CONFIG_DIR = "${config.home.homeDirectory}/.config/ags";
  };
}
