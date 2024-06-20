{ config, lib, pkgs, ... }:
let
in
{
  programs.sway.enable = true;
  programs.waybar.enable = true;
}
