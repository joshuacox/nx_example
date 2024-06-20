{pkgs, config, lib, ...}:
with pkgs;
with lib;
{
  services.pcscd.enable = true;
  services.udev.packages = [ yubikey-personalization ];
  programs = {
    ssh.startAgent = false;
  };
  environment.systemPackages = [
    gnupg
    openssl
    yubikey-personalization
    yubioath-flutter
    yubico-pam
    yubico-piv-tool
    pinentry-qt
  ];
}
