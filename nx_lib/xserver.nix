{ config, lib, pkgs, ... }:
let
in
{
  services = {
    xserver = {
      enable = true;
    };
  };
}
