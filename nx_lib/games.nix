{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    #steam-gamescope
    dwarf-fortress-packages.dwarf-fortress-full
    gamescope
    goverlay
    lutris
    mangohud
    protontricks
    protonup
    retroarchFull
    steam-run
    steam-tui
    steamcmd
    tinyfugue
    vkBasalt
    yquake2-all-games
  ];
}
