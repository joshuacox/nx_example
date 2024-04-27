{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    chromium
  ];
}
