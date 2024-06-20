{ config, lib, pkgs, ... }:
let
in
{
  programs.hyprland.enable = true;
  programs.waybar.enable = true;
  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [ 
    swaynotificationcenter
    hypridle
    hyprlock
    hyprpaper
    hyprcursor
  ];
  xdg.portal = {
    xdgOpenUsePortal = true;
    enable = true;
    # wlr.enable = true;
    # lxqt.enable = true;
    extraPortals = [
      # pkgs.xdg-desktop-portal-gnome
      # pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      # pkgs.xdg-desktop-portal-kde
      # pkgs.xdg-desktop-portal-wlr
    ];
  };
}
