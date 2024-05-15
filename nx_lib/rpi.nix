
{ config, lib, pkgs, ... }:
let
in
{
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    kernelParams = [
      "cgroup_memory=1"
      "cgroup_enable=cpuset"
      "cgroup_enable=memory"
    ];
    kernelModules = [ 
      "lz4" 
      "nfs" 
      "zstd" 
      "z3fold" 
    ];
    initrd = {
      availableKernelModules = [ "nfs" "xhci_pci" "usbhid" "usb_storage" ];
      kernelModules = [ 
	"lz4" 
	"z3fold" 
        "nfs" 
        "nvme" 
        "zstd" 
        "cryptd" 
        "dm-snapshot" 
      ];
    };
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  hardware.enableRedistributableFirmware = true;
}
