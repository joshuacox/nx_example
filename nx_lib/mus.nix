{ config, lib, pkgs, ... }:
{
  musnix = {
    enable = true;
    alsaSeq.enable = true;
    ffado.enable = true;
    rtcqs.enable = true;
    #kernel.realtime = true;
  };
  # Enable sound.
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
  };
}
