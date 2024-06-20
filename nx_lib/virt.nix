{ config, lib, pkgs, ... }:
let
in
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      };
    };
  };
}
