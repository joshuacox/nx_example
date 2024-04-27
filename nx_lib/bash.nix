{ config, lib, pkgs, ... }:
let
in
{
  environment.shells = with pkgs; [
    bash
  ];
  environment.systemPackages = with pkgs; [ 
    bash
    bats
  ];
}
