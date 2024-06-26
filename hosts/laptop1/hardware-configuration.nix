# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "nixcrypt/root";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "nixpool/nix";
      fsType = "zfs";
    };

  fileSystems."/var" =
    { device = "nixcrypt/var";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "nixcrypt/home";
      fsType = "zfs";
    };

  fileSystems."/unreal" =
    { device = "unreal/unreal";
      fsType = "zfs";
    };

  fileSystems."/quake" =
    { device = "quake/quake";
      fsType = "zfs";
    };

  fileSystems."/home/user1/.cache" =
    { device = "nixpool/cache";
      fsType = "zfs";
    };

  fileSystems."/opt" =
    { device = "/dev/disk/by-uuid/7773dd61-bc6f-4953-9ae2-c3ed6dd92896";
      fsType = "ext4";
    };

  fileSystems."/node_modules" =
    { device = "/dev/disk/by-uuid/0f476876-734d-429b-8a17-8b891ebbb92c";
      fsType = "xfs";
    };

  fileSystems."/caboose" =
    { device = "/dev/disk/by-uuid/e29d471b-5d56-436c-bff8-67bae0c6037d";
      fsType = "ext4";
    };

  fileSystems."/Ventoy" =
    { device = "/dev/disk/by-uuid/3400-A410";
      fsType = "exfat";
    };

  fileSystems."/var/lib/docker" =
    { device = "/dev/disk/by-uuid/5c59f203-a309-4570-a563-74d6b9709eeb";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E8BA-9566";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/8700cf9b-72d4-44df-afee-c1d71cbb18b6"; "options" = [ "nofail" "noatime" ]; "priority" =  0; "discardPolicy" = "once"; }
    ];


  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
