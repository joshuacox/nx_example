{ config, lib, pkgs, ... }:
let
in
{
  programs.java.enable = true; 
  programs.steam = {
    #package = pkgs.steam.override { withJava = true; };
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  environment.systemPackages = with pkgs; [ 
    steamcmd
    steam-tui
  ];
}
