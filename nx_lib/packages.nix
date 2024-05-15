{ config, lib, pkgs, ... }:
let
in
{
  environment.variables = {
    PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig";
  };
  environment.systemPackages = with pkgs; [ 
    ansible
    automatic-timezoned
    colmena
    docker
    parted
    pkg-config
    pyenv
    rainbowstream
    ruby
    rustup
    wego
    whois
  ];
}
