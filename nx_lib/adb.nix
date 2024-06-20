{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    android-tools
    scrcpy
  ];
  programs.adb.enable = true;
}
