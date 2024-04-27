{ config, lib, pkgs, ... }:
let
in
{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
