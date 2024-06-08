{ config, lib, pkgs, ... }:
{
  boot = {
    plymouth = {
      enable = true;
      theme = "bgrt";
      #logo = "${nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
      font = "${pkgs.dejavu_fonts.minimal}/share/fonts/truetype/DejaVuSans.ttf";
    };
  };
}
