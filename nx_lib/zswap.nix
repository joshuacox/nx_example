{ config, lib, pkgs, ... }:
{
  zramSwap.enable = false;
  systemd.services = {
    zswap-configure = {
      description = "Configure zswap";
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "oneshot";
      script = ''
        echo zstd > /sys/module/zswap/parameters/compressor
        echo z3fold > /sys/module/zswap/parameters/zpool
      '';
    };
  };
  boot = {
    kernelParams = [ 
      "zswap.enabled=1"
      "zswap.compressor=zstd"
      "zswap.max_pool_percent=8"
      "zswap.zpool=z3fold"
      "zswap.accept_threshold_percent=88"
    ];
    kernelModules = [ 
      "zstd" 
      "z3fold" 
    ];
    initrd = { 
      availableKernelModules = [ 
        "lz4" 
        "zstd" 
        "z3fold" 
      ];
      kernelModules = [ 
        "lz4" 
        "z3fold" 
        "zstd" 
      ];
    };
  };
}
