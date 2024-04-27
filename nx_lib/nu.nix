{ config, lib, pkgs, ... }:
let
in
{
  programs.mtr.enable = true;
  environment.systemPackages = with pkgs; [ 
    nushell
  ];
}
