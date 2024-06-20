{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    nodejs
    yarn
    yarn2nix
    node2nix
  ];
}
