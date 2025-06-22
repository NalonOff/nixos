{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      
      # Configuration des moteurs de recherche
      search = {
        default = "DuckDuckGo";
        engines = {
          "DuckDuckGo" = {
            urls = [{ template = "https://duckduckgo.com/?q={searchTerms}"; }];
            iconUpdateURL = "https://duckduckgo.com/favicon.ico";
            definedAliases = [ "@ddg" ];
          };
          
          "Startpage" = {
            urls = [{ template = "https://www.startpage.com/sp/search?query={searchTerms}"; }];
            iconUpdateURL = "https://www.startpage.com/sp/cdn/favicons/favicon-96x96.png";
            definedAliases = [ "@sp" ];
          };
          
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "https://nixos.org/favicon.png";
            definedAliases = [ "@np" ];
          };
        };
        force = true;
      };
      
      # Paramètres Firefox
      settings = {
        # Barre d'onglets verticale native
        "sidebar.verticalTabs" = true;
        "sidebar.revamp" = true;
        "browser.tabs.tabmanager.enabled" = true;
        "browser.toolbars.bookmarks.visibility" = "always";
        
        "ui.systemUsesDarkTheme" = 1;

        # Confidentialité
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.clearOnShutdown.downloads" = false;
        "privacy.clearOnShutdown.history" = false;
        
        # Télémétrie désactivée
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.unified" = false;
        
        # Paramètres généraux
        "browser.startup.homepage" = "about:home";
        "browser.newtabpage.enabled" = true;
        "browser.download.useDownloadDir" = false;
        "browser.tabs.loadInBackground" = true;
        "browser.urlbar.suggest.searches" = true;
        "browser.urlbar.suggest.topsites" = false;
        
        # Sécurité
        "dom.security.https_only_mode" = true;
        "network.dns.disablePrefetch" = true;
        "network.prefetch-next" = false;
        
        # Performance
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
      }; 
     
      # Signets utiles
      bookmarks = [
        {
          name = "Nix Ecosystem";
          toolbar = true;
          bookmarks = [
            {
              name = "NixOS";
              url = "https://nixos.org/";
            }
            {
              name = "Home Manager Options";
              url = "https://nix-community.github.io/home-manager/options.html";
            }
            {
              name = "Nix Packages";
              url = "https://search.nixos.org/packages";
            }
          ];
        }
      ];
    };
  };
}
