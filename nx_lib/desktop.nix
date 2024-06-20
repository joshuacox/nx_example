{ config, lib, pkgs, ... }:
let
in
{
  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [ 
    polkit-kde-agent
    lxqt.lxqt-policykit
  ];
  imports =
    [
      ./adb.nix
      ./admin.nix
      ./bash.nix
      ./base.nix
      ./brave.nix
      ./cachix.nix
      ./ccache.nix
      ./chromium.nix
      ./commonboot.nix
      ./comms.nix
      ./font.nix
      ./firefox.nix
      ./games.nix
      ./gcomms.nix
      ./guipackages.nix
      ./gpg.nix
      ./input-leap.nix
      ./java.nix
      ./jekyll.nix
      ./k8s_tools.nix
      ./mus.nix
      ./nu.nix
      ./neovim.nix
      ./nodejs.nix
      ./optimizer.nix
      ./packages.nix
      ./rust.nix
      # ./steam.nix
      # ./virt.nix
      ./vivaldi.nix
      # ./waydroid.nix
      # ./xdg.nix
      ./yubikey.nix
      ./zsh.nix
    ];
}
