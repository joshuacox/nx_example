{ config, lib, pkgs, ... }:
let
in
{
  specialisation = {
    waydroid.configuration = {
      system.nixos.tags = [ "waydroid" ];
      services.greetd = {
        enable = true;
        settings = {
         default_session.command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --time \
            --asterisks \
            --user-menu \
            --cmd /home/thoth/bin/mutter-session.sh
        '';
        };
      };

      environment.etc."greetd/environments".text = ''
        sway
        byobu
        nu
        zsh
        fish
        xonsh
        elvish
        bash
        dash
      '';
    };
    sddm.configuration = {
      system.nixos.tags = [ "sddm" ];
      services = {
        xserver.enable = true;
        displayManager.sddm = {
          enable = true;
          wayland = {
            enable = false;
            compositor = "weston";
          };
        };
      };
    };
  };
}
