{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    nvidia-docker
    docker_25
    nvidia-container-toolkit
  ];
  systemd.enableUnifiedCgroupHierarchy = false;
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation = {
    containers = {
      enable = true;
      cdi.dynamic.nvidia.enable = true;
    };
    docker = {
      enable = true;
      #enableNvidia = true;
      # CDI is feature-gated and only available from Docker 25 and onwards
      #package = pkgs.docker_26;
      package = pkgs.docker_25;
      #setSocketVariable = true;
      daemon.settings = {
        features.cdi = true;
        default-runtime = "nvidia";
        runtimes.nvidia.path = "${pkgs.nvidia-docker}/bin/nvidia-container-runtime";
        exec-opts = ["native.cgroupdriver=cgroupfs"];
      };
      #storageDriver = "zfs";
    };
    #oci-containers.backend = "docker";
  };
}
