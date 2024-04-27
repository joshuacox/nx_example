{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    automatic-timezoned
    age
    aria
    atool
    bat
    byobu
    #bumblebee
    colmena
    cowsay
    curl
    dconf
    dejavu_fonts
    docker
    dig
    direnv
    dorion
    eza
    file
    ffmpeg
    fortune
    git
    git-crypt
    glow
    gnupg
    hack-font
    home-manager
    htop
    httpie
    iotop
    iftop
    keychain
    kakoune
    kak-lsp
    k3s
    linuxPackages.cpupower
    lolcat
    lshw
    mtr
    nano
    neomutt
    ncdu
    niv
    nixos-generators
    nixos-icons
    nmap
    nushell
    ollama
    perlPackages.AppClusterSSH
    ponysay
    powertop
    pv
    pyenv
    sops
    ssh-to-age
    ssh-to-pgp
    starship
    tealdeer
    tmux
    tmuxinator
    unzip
    wget
    wego
    wireguard-tools
    yadm
    zip
  ];
}