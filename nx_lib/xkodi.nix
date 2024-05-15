{ config, lib, pkgs, ... }:
let
in
{
  # Enable the Plasma 5 Desktop Environment.
  services = {
    xserver = {
      displayManager.autoLogin.enable = true;
      displayManager.autoLogin.user = "kodi";
      enable = true;
      desktopManager.kodi.enable = true;
      # This may be needed to force Lightdm into 'autologin' mode.
      # Setting an integer for the amount of time lightdm will wait
      # between attempts to try to autologin again. 
      displayManager.lightdm.autoLogin.timeout = 3;
      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;
    };
  };
  # Define a user account
  users.extraUsers.kodi.isNormalUser = true;
  nixpkgs.config.kodi.enableAdvancedLauncher = true;
  environment.systemPackages = [
	  (pkgs.kodi.passthru.withPackages (kodiPkgs: with kodiPkgs; [
		  jellyfin
	  ]))
  ];
  networking.firewall = {
    allowedTCPPorts = [ 8080 ];
    allowedUDPPorts = [ 8080 ];
  };
}
