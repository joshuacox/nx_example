
{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [
    atop
    byobu
    cryptsetup
    curl
    fdupes
    git
    gnupg
    gotop
    htop
    iftop
    ncdu
    nmon
    sysstat
    tmux
    tmuxinator
    vim
    wget
  ];
}
