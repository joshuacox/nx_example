{ config, lib, pkgs, ... }:
let
in
{
  programs.ssh.askPassword = "ksshaskpass";
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
  };
  hardware = {
    pulseaudio.enable = lib.mkForce false;
  };
}
