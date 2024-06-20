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
#  hardware = {
#pulseaudio.enable = true;
#  };
  environment.systemPackages = with pkgs; [ 
    ardour
    cardinal
    carla
    guitarix
    hydrogen
    jack2
    qjackctl
    qpwgraph
    qsynth
    qtractor
    rakarrack
    wireplumber
    zynaddsubfx
  ];
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

}
