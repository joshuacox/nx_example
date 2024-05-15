
{ config, lib, pkgs, ... }:
let
in
{
  sops = {
    secrets.k3s_token.sopsFile = ../secrets/k3s.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  };
  services = {
    openiscsi = {
      enable = true;
      name = "${config.networking.hostName}-initiatorhost"; 
    };
    k3s = {
      enable = true;
      tokenFile = config.sops.secrets.k3s_token.path;
      extraFlags = toString [
        "--flannel-backend=wireguard-native"
        "--kubelet-arg=node-ip=0.0.0.0"
        "--cluster-cidr=10.42.0.0/16"
        "--service-cidr=10.43.0.0/16"
        #"--cluster-cidr=10.42.0.0/16,2001:cafe:42::/56"
        #"--service-cidr=10.43.0.0/16,2001:cafe:43::/112"
      ];
    };
  };
  networking.firewall = {
    allowedUDPPorts = [
      8472
    ];
    allowedTCPPorts = [
      22
      2379
      2380
      6443
      6444
      9000
    ];
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    k3s
    nfs-utils
  ];
}
