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
          #conf_dir = "/var/lib/rancher/k3s/agent/etc/cni/net.d/";
          #snapshotter = "zfs";
        };
        # Optionally set private registry credentials here instead of using /etc/rancher/k3s/registries.yaml
        # plugins."io.containerd.grpc.v1.cri".registry.configs."registry.example.com".auth = {
        #  username = "";
        #  password = "";
        # };
      };
  };
  boot.kernelModules = [ "nvme_tcp" ];
  services = {
    openiscsi = {
      enable = true;
      name = "${config.networking.hostName}-initiatorhost"; 
    };
  };
  environment.systemPackages = with pkgs; [
    nfs-utils
    nerdctl
  ];
}
