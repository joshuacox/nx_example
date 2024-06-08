
{ config, lib, pkgs, ... }:
let
in
{
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
  };
  environment.systemPackages = with pkgs; [ docker runc ];
}
