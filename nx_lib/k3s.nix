
{ config, lib, pkgs, ... }:
let
in
{
  sops = {
    secrets.k3s_token.sopsFile = ../secrets/k3s.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  };
  services = {
    k3s = {
      enable = true;
      tokenFile = config.sops.secrets.k3s_token.path;
    };
  };
  networking.firewall = {
    allowedTCPPorts = [
      22
      6443
      6444
      9000
    ];
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    k3s
  ];
}
