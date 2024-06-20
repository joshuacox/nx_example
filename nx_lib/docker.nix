{ config, lib, pkgs, ... }:
let
in
{
  virtualisation = {
    docker.enable = true;
  };
}
