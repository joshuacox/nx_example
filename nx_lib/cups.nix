{ config, lib, pkgs, ... }:
let
in
{
  # Enable CUPS to print documents.
  services.printing.enable = true;
}
