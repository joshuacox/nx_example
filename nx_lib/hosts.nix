{ config, lib, pkgs, ... }:
{
  networking = {
    hosts = {
      "10.11.5.11" = [
        "xdrancher.oltorf.net"
      ];
      "0.0.0.0" = [
        "lifehackguru.org"
        "www.lifehackguru.org"
      ];
    };
  };
}
