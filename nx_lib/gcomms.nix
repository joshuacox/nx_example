{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    discord
    element-desktop
    pidgin-with-plugins
    remmina
    signal-desktop
    skypeforlinux
    slack-dark
    telegram-desktop
    zoom-us
  ];
}
