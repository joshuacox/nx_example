{ config, lib, pkgs, inputs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    #inputs.nx.packages."${pkgs.system}".nx
    inputs.nx.packages."x86_64-linux".nx
    nix-index
  ];
}
