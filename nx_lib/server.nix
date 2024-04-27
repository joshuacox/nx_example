
{ config, lib, pkgs, ... }:
let
in
{
  users.users.root.hashedPassword = "!";

  environment.systemPackages = with pkgs; [
    curl
    git
    gnupg
    vim
    wget
  ];

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  security.sudo.wheelNeedsPassword = false;
}
