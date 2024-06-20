{ config, lib, pkgs, ... }:
let
in
{
  programs.gnupg.agent = {
    pinentryPackage = lib.mkForce pkgs.pinentry-qt;
    enable = true;
    enableSSHSupport = true;
  };
}
