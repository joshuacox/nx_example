{ config, lib, pkgs, ... }:
let
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    package = pkgs.nixFlakes;
  };
  users.defaultUserShell = pkgs.zsh;
  zramSwap.enable = false;
  security.protectKernelImage = false;
  system.stateVersion = "23.11"; # Did you read the comment?
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver
  nixpkgs = {
    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
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

  # Enable sound.
  sound.enable = true;

  systemd.services = {
    ollama.serviceConfig.DynamicUser = lib.mkForce false;
    zswap-configure = {
      description = "Configure zswap";
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "oneshot";
      script = ''
        echo zstd > /sys/module/zswap/parameters/compressor
        echo z3fold > /sys/module/zswap/parameters/zpool
      '';
    };
  };
  boot = {
    # Enable binfmt emulation of aarch64-linux.
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    tmp = {
      useTmpfs = true;
    };
    zfs = {
      forceImportRoot = false;
      allowHibernation = true;
    };
    plymouth = {
      enable = true;
      theme = "bgrt";
      #logo = "${nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
      font = "${pkgs.dejavu_fonts.minimal}/share/fonts/truetype/DejaVuSans.ttf";
    };
    resumeDevice =  "/dev/disk/by-uuid/deadbeef123";
    #kernel.sysctl.vm.swappiness = 33; 
    kernelParams = [ 
      "zswap.enabled=1"
      "zswap.compressor=zstd"
      "zswap.max_pool_percent=8"
      "zswap.zpool=z3fold"
      "zswap.accept_threshold_percent=88"
      "i915.force_probe=9a49" 
      "resume=UUID=deadbeef123"
    ];
    kernelModules = [ 
      "lz4" 
      "zstd" 
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
      luks.devices = {
        "cryptstorage".device = "/dev/disk/by-uuid/deadbeef456";
        "cryptroot".device = "/dev/disk/by-uuid/deadbeef789";
      };
      availableKernelModules = [ 
        "xhci_pci" 
        "thunderbolt" 
        "vmd" 
        "lz4" 
        "zstd" 
        "z3fold" 
        "usb_storage" 
        "sd_mod" 
        "rtsx_pci_sdmmc" 
      ];
      kernelModules = [ 
        "lz4" 
        "z3fold" 
        "nvme" 
        "zstd" 
        "aesni_intel" 
        "cryptd" 
        "dm-snapshot" 
      ];
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 51820 ];
    };
    hostName = "laptop1"; # Define your hostname.
    hostId = "deadbeef";
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  };
  time.timeZone = "America/Rainy_River";
  services = {
    automatic-timezoned.enable = true;
    zfs.autoScrub.enable = true;
    ollama = {
      enable = true;
      acceleration = "cuda";
      home = "/extra_space/ollama";
    };
    xserver = {
      # Load nvidia driver for Xorg and Wayland
      videoDrivers = [ "nvidia" ];
      dpi = 180;
      # Enable the X11 windowing system.
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      libinput.enable = true;
    };
  };
  security.sudo.wheelNeedsPassword = false;
  # bigger tty fonts
  console.font =
    "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  environment.variables = {
    EDITOR = "vim";
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
  environment.shells = with pkgs; [
    bash
  ];
  environment.systemPackages = with pkgs; [ 
    nvidia-docker
  ];
  hardware = {
    pulseaudio.enable = true;
  # Enable OpenGL
    opengl = {
      enable =  true;
      driSupport =  true;
      driSupport32Bit =  true;
      extraPackages = with pkgs; [
        vaapiVdpau
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        libvdpau-va-gl
      ];
    };
    nvidia = {
      # Modesetting is required.
      modesetting.enable =  true;
      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
      # of just the bare essentials.
      powerManagement.enable =  false;
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained =  true;
      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open =  false;
      # Enable the Nvidia settings menu,
	  # accessible via `nvidia-settings`.
      nvidiaSettings =  true;
      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
      #package = config.boot.kernelPackages.nvidiaPackages.stable;
      package =  config.boot.kernelPackages.nvidiaPackages.production;
      prime = {
	offload = {
	  enable =  true;
	  enableOffloadCmd =  true;
	};
	# sync should not be enabled with offload at the same time
	sync.enable =  false;
	# Make sure to use the correct Bus ID values for your system!
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:01:0:0";
      };
    };
  };
}
