{ config, lib, pkgs, ... }:
{
#--sessions "$XDG_CONFIG_DIRS:/unreal/git/wayland-sessions" \
#--xsessions "$XDG_CONFIG_DIRS:/unreal/git/xsessions" \
#--greeting '⛩️🕌⛪🕍📿🙏❤️🌹❤️🫶🕊️Namaste!✌️🐔🐖🦆🐧🦢🦜🦩🦃🐓" \
#--issue \
#--cmd hyprland
  config = lib.mkIf (config.specialisation != {}) {
    services.greetd = {
      enable = true;
      settings = {
       default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --remember \
          --remember-user-session \
          --asterisks \
          --user-menu
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
}
