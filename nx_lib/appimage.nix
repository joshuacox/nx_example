{ config, lib, pkgs, ... }:
let
in
{
  programs.appimage.binfmt = true;
}
