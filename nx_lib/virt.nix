{ config, lib, pkgs, ... }:
let
in
{
  virtualisation = {
    docker.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
	package = pkgs.qemu_kvm;
	runAsRoot = true;
	swtpm.enable = true;
	ovmf = {
	  enable = true;
          #packages = [(pkgs.unstable.OVMF.override {
	  packages = [(pkgs.OVMF.override {
	    secureBoot = true;
	    tpmSupport = true;
	  }).fd];
	};
      };
    };
  };
}
