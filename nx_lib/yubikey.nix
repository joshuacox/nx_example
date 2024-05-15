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
      pinentryFlavor = "qt";
    };
  };
  environment.systemPackages = [
    gnupg
    yubikey-personalization
    pinentry-qt
  ];
}
