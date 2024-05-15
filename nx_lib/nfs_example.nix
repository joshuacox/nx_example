{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [
    libnfs
    nfs-utils
  ];
  services.nfs.server.enable = true;
  services.rpcbind.enable = true;
  systemd.mounts = let commonMountOptions = {
    type = "nfs";
    mountConfig = {
      Options = "noatime";
    };
  };
  in
  [
    (commonMountOptions // {
      what = "192.168.1.50:/mnt/git" ;
      where = "/mnt/git";
    })
    (commonMountOptions // {
      what = "192.168.1.50:/mnt/hg" ;
      where = "/mnt/hg";
    })
  ];

  systemd.automounts = let commonAutoMountOptions = {
    wantedBy = [ "multi-user.target" ];
    automountConfig = {
      TimeoutIdleSec = "600";
    };
  };
  in
  [
    (commonAutoMountOptions // { where = "/mnt/git"; })
    (commonAutoMountOptions // { where = "/mnt/hg"; })
  ];
}
