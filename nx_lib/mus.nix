{ config, lib, pkgs, ... }:
{
  musnix = {
    enable = true;
    alsaSeq.enable = true;
    ffado.enable = true;
    rtcqs.enable = true;
    #kernel.realtime = true;
  };
}
