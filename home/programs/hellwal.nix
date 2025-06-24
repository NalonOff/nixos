{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    hellwal
    swww
  ];
}

