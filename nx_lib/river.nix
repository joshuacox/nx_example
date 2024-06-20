{ config, lib, pkgs, ... }:
let
in
{
  programs.river.enable = true;
  programs.waybar.enable = true;
}
