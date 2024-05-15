{ config, lib, pkgs, ... }:
let
in
{
  nixpkgs = {
    config = {
      allowUnfree = lib.mkDefault true;
      nvidia.acceptLicense = lib.mkDefault true;
    };
  };
  environment.systemPackages = with pkgs; [ 
    nvidia-docker
    nvtop
  ];
  hardware = {
  # Enable OpenGL
    opengl = {
      enable = lib.mkDefault true;
      driSupport = lib.mkDefault true;
      driSupport32Bit = lib.mkDefault true;
      #extraPackages = with pkgs; [
      #  vaapiVdpau
#	intel-media-driver # LIBVA_DRIVER_NAME=iHD
#	intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
#	libvdpau-va-gl
#      ];
    };
    nvidia = {
      # Modesetting is required.
      modesetting.enable = lib.mkDefault true;
      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
      # of just the bare essentials.
      powerManagement.enable = lib.mkDefault false;
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = lib.mkDefault true;
      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = lib.mkDefault false;
      # Enable the Nvidia settings menu,
	  # accessible via `nvidia-settings`.
      nvidiaSettings = lib.mkDefault true;
      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
      #package = config.boot.kernelPackages.nvidiaPackages.stable;
      package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.production;
      prime = {
	offload = {
	  enable = lib.mkDefault true;
	  enableOffloadCmd = lib.mkDefault true;
	};
	# sync should not be enabled with offload at the same time
	sync.enable = lib.mkDefault false;
	# Make sure to use the correct Bus ID values for your system!
        intelBusId = lib.mkDefault "PCI:0:2:0";
        nvidiaBusId = lib.mkDefault "PCI:01:0:0";
      };
    };
  };
}
