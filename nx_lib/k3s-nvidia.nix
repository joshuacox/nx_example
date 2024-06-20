
{ config, lib, pkgs, ... }:
let
in
{
  imports =
    [
      ./k3s.nix
    ];
  hardware.nvidia-container-toolkit.enable = true;
}
