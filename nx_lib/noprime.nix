{ config, lib, pkgs, ... }:
let
in
{
  hardware = {
    nvidia = {
      powerManagement.finegrained = lib.mkDefault false;
      prime = {
	offload = {
	  enable = lib.mkForce false;
	  enableOffloadCmd = lib.mkForce false;
	};
	# sync should not be enabled with offload at the same time
	sync.enable = lib.mkForce true;
      };
    };
  };
}
