{ config, lib, pkgs, ... }:
{
  zramSwap.enable = true;
  boot = {
    kernelParams = [ 
      "zswap.enabled=0"
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
