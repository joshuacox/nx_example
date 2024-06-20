{ config, lib, pkgs, ... }:
let
in
{
  virtualisation = {
    libvirtd = {
      qemu = {
	ovmf = {
	  enable = true;
	  packages = [(pkgs.OVMF.override {
	    secureBoot = true;
	    tpmSupport = true;
	  }).fd];
	};
      };
    };
  };
}
