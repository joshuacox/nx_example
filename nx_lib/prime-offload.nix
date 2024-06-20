{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    bumblebee 
    glxinfo
  ];
#  programs.steam.package = pkgs.steam.override {
#    withPrimus = true;
#  };
  specialisation = {
    nvidia-offload.configuration = {
      system.nixos.tags = [ "nvidia-offload" ];
      hardware = {
        nvidia = {
          powerManagement.finegrained = lib.mkDefault true;
          prime = {
          offload = {
            enable = lib.mkForce true;
            enableOffloadCmd = lib.mkForce true;
          };
          # sync should not be enabled with offload at the same time
          sync.enable = lib.mkForce false;
          };
        };
      };
    };
  };
}
