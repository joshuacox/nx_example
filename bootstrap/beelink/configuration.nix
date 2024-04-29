{ config, lib, pkgs, ... }:
let
in
{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  users = {
    mutableUsers = true;
    users = {
      admin = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 deadbeef admin"
        ];
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" ];
      };
    };
  };
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    package = pkgs.nixFlakes;
  };
  #zramSwap.enable = true;
  security.protectKernelImage = false;
  system.stateVersion = "23.11"; # Did you read the comment?
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver
  nixpkgs = {
    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
      packageOverrides = pkgs: with pkgs; {
        intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
      };
    };
  };

  # Enable sound.
  sound.enable = true;
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.forceImportRoot = true;
    zfs.devNodes = "/dev/disk/by-partuuid";
    # Enable binfmt emulation of aarch64-linux.
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    tmp = {
      useTmpfs = true;
    };
    kernelParams = [ 
      "i915.force_probe=9a49" 
    ];
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
        useOSProber = false;
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
        "ext4" 
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

  networking = {
    firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 51820 ];
    };
    hostName = "beelink"; # Define your hostname.
    hostId = "deadbeef";
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  };
  time.timeZone = "America/Rainy_River";
  services = {
    zfs.autoScrub.enable = true;
  };
  security.sudo.wheelNeedsPassword = false;
  environment.shells = with pkgs; [
    bash
  ];
  environment.systemPackages = with pkgs; [ 
    ((vim_configurable.override {  }).customize{
      name = "vim";
      # Install plugins for example for syntax highlighting of nix files
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-lastplace ];
        opt = [];
      };
      vimrcConfig.customRC = ''
        " your custom vimrc
        set mouse=
        set nocompatible
        set backspace=indent,eol,start
        " Turn on syntax highlighting by default
        syntax on
        " ...
      '';
    })
  ];
}
