{pkgs, config, lib, ...}:
with pkgs;
with lib;
{
  services.pcscd.enable = true;
  services.udev.packages = [ yubikey-personalization ];
  programs = {
    ssh.startAgent = false;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
  environment.systemPackages = [
    gnupg
    openssl
    yubikey-personalization
    pinentry-qt
  ];
}
