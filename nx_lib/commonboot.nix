{ config, lib, pkgs, ... }:
{
  boot = {
    # Enable binfmt emulation of aarch64-linux.
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    kernelModules = [ 
      "lz4" 
      "zstd" 
      "nfs" 
      "z3fold" 
      "kvm-intel"
    ];
    loader = {
      timeout = 1;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        configurationName = "NixOS";
        configurationLimit = 15;
        device = "nodev";
        useOSProber = true;
        zfsSupport = true;
        efiSupport = true;
        fontSize = 36;
        mirroredBoots = [
          { devices = [ "nodev"]; path = "/boot"; }
        ];
      };
    };
    initrd = { 
      supportedFilesystems = [
        "nfs" 
        "zfs" 
      ];
      availableKernelModules = [ 
        "lz4" 
        "nfs" 
        "rtsx_pci_sdmmc" 
        "sd_mod" 
        "usb_storage" 
        "thunderbolt" 
        "vmd" 
        "xhci_pci" 
        "zstd" 
        "z3fold" 
      ];
      kernelModules = [ 
        "aesni_intel" 
        "cryptd" 
        "dm-snapshot" 
        "lz4" 
        "nfs" 
        "nvme" 
        "z3fold" 
        "zstd" 
      ];
    };
  };
}
