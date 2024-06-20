{ config, lib, pkgs, ... }:
let
in
{
  services = {
    #displayManager.sddm.enable = true;
    xserver = {
      desktopManager.plasma5.enable = true;
    };
  };
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
  programs.dconf.enable = true;
  environment.sessionVariables = {
    NIX_PROFILES = "${pkgs.lib.concatStringsSep " " (pkgs.lib.reverseList config.environment.profiles)}";
  };
}
