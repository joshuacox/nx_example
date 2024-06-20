{ config, lib, pkgs, ... }:
let
in
{
  imports = [
      ./desktop.nix
  ];
  environment.systemPackages = with pkgs; [ 
    powertop
  ];
}
