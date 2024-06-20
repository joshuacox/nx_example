{ config, lib, pkgs, ... }:
let
in
{
  specialisation = {
    nvidia-sync.configuration = {
      system.nixos.tags = [ "nvidia-sync" ];
      hardware.nvidia.powerManagement.finegrained = lib.mkDefault false;
    };
  };
}
