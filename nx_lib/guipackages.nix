{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    alacritty
    blender
    #bumblebee
    dorion
    gnumeric
    gimp
    inkscape
    libreoffice-qt
    mplayer
    pidgin-with-plugins
    pinentry-qt
    persepolis
    signal-desktop
    slack-dark
    telegram-desktop
    terminator
    tilda
    virt-manager
    vlc
    vscodium-fhs
  ];
}
