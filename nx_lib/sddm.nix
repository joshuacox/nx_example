{ config, lib, pkgs, ... }:
let
in
{
  services = {
    xserver.enable = true;
    displayManager.sddm = {
      enable = true;
      # wayland = {
        # enable = true;
        # compositor = "kwin";
      # };
    };
  };
}
