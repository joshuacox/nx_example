{ config, lib, pkgs, ... }:
let
# This can be used to generate the cert on the fly
#  mkCert = domain: pkgs.runCommand "cert" { } ''
#    mkdir $out
#    export HOME=$(mktemp -d)
#    ${pkgs.mkcert}/bin/mkcert -cert-file ${domain}.pem -key-file ${domain}-key.pem ${domain}
#  '';
in
{
  services = {
    ollama = {
      enable = lib.mkDefault true;
      acceleration = "cuda";
    };
  };
  systemd.services = {
    ollama.serviceConfig.DynamicUser = lib.mkForce false;
  };
  environment.systemPackages = with pkgs; [ 
    ollama
  ];
}
