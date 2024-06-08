{ config, lib, pkgs, ... }:
let
in
{
  #programs.steam.package = pkgs.steam.override {
     #withPrimus = true;
     #extraPkgs = pkgs: [ bumblebee glxinfo ];
  #};
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
}
