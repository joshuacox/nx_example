{ config, lib, pkgs, ... }:
let
in
{
  xdg.portal = {
    xdgOpenUsePortal = true;
    enable = true;
    # wlr.enable = true;
    # lxqt.enable = true;
    # extraPortals = [
      # pkgs.xdg-desktop-portal-gnome
      # pkgs.xdg-desktop-portal-gtk
      # pkgs.xdg-desktop-portal-hyprland
      # pkgs.xdg-desktop-portal-kde
      # pkgs.xdg-desktop-portal-wlr
    # ];
  };
}
