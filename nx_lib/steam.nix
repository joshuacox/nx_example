{ config, lib, pkgs, ... }:
let
in
{
  #package = pkgs.steam.override {
    #withJava = true;
    #withPrimus = true;
    #extraPkgs = pkgs: [ bumblebee glxinfo ];
  #};
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
}
