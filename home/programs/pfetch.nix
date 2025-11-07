{ config, pkgs, ... }:

{
  home.sessionVariables = {
    PF_INFO = "title os kernel uptime pkgs memory";
  };
}
