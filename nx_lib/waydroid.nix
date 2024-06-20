{ config, lib, pkgs, ... }:
let
in
{
  virtualisation.waydroid.enable = true;
  environment.systemPackages = with pkgs; [ 
    waydroid
  ];
}
