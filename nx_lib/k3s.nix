
{ config, lib, pkgs, ... }:
let
in
{
  virtualisation.containerd = {
    enable = true;
    settings =
      let
        fullCNIPlugins = pkgs.buildEnv {
          name = "full-cni";
          paths = with pkgs;[
            cni-plugins
            cni-plugin-flannel
          ];
        };
      in {
        plugins."io.containerd.grpc.v1.cri".cni = {
          bin_dir = "${fullCNIPlugins}/bin";
          conf_dir = "/var/lib/rancher/k3s/agent/etc/cni/net.d/";
          snapshotter = "zfs";
        };
        # Optionally set private registry credentials here instead of using /etc/rancher/k3s/registries.yaml
        # plugins."io.containerd.grpc.v1.cri".registry.configs."registry.example.com".auth = {
        #  username = "";
        #  password = "";
        # };
      };
  };
  boot.kernelModules = [ "nvme_tcp" ];
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
      # TODO describe how to enable zfs snapshotter in containerd
      enable = true;
      #package = pkgs.k3s_1_29;
      package = pkgs.k3s_1_28;
      #package = pkgs.k3s_1_27;
      tokenFile = config.sops.secrets.k3s_token.path;
    };
  };
  networking.firewall = {
    allowedUDPPorts = [
      8472
    ];
    allowedTCPPorts = [
      22
      80
      443
      2049
      2379
      2380
      3260 
      6443
      6444
      7946
      8000
      8002
      8500
      8501
      9000
      9500
      9501
      9502
      9503
    ];
    allowedTCPPortRanges = [
			{ from = 10000; to = 31000; }
    ];
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    nfs-utils
    nerdctl
  ];
}
