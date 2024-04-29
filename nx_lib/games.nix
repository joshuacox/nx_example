{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    #steam-gamescope
    steam-run
    steam-tui
    steamcmd
    protontricks
    protonup
    lutris
    retroarchFull
    gamescope
    vkBasalt
    mangohud
    goverlay
  ];
}
