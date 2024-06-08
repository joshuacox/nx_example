{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    discord
    element-desktop
    pidgin-with-plugins
    remmina
    signal-desktop
    skypeforlinux
    slack-dark
    telegram-desktop
    zoom-us
  ];
  nixpkgs = {
    config = {
      packageOverrides = pkgs: with pkgs; {
        intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
        pidgin-with-plugins = pkgs.pidgin.override {
          ## Add whatever plugins are desired (see nixos.org package listing).
          plugins = with pkgs; [ 
            pidgin-otr
            purple-discord
            purple-matrix
            purple-slack
          ];
        };
      };
    };
  };
}
