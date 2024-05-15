{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    weechat
    irssi
    neomutt
  ];
}
