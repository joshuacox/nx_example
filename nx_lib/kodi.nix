{ config, lib, pkgs, ... }:
let
in
{
  services = {
    cage.user = "kodi";
    cage.program = "${pkgs.kodi-wayland}/bin/kodi-standalone";
    cage.enable = true;
  };
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
