{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    age
    aria
    atool
    bc
    bat
    btop
    blahaj
    byobu
    cowsay
    cryptsetup
    curl
    curlie
    dconf
    dejavu_fonts
    dig
    dog
    dogdns
    direnv
    duf
    dust
    eza
    file
    fortune
    fzf
    lsof
    mcfly
    mcfly-fzf
    git
    git-crypt
    glances
    glow
    gnupg
    gnumake
    home-manager
    gtop
    htop
    httpie
    iotop
    iftop
    jq
    keychain
    linuxPackages.cpupower
    lolcat
    lshw
    mc
    mise
    mtr
    nano
    ncdu
    nfs-utils
    libnfs
    mprocs
    niv
    nixos-icons
    nushell
    perlPackages.AppClusterSSH
    ponysay
    procs
    pv
    pwgen
    restic
    rsync
    rclone
    sops
    ssh-to-age
    ssh-to-pgp
    smartmontools
    starship
    syncrclone
    tealdeer
    tmux
    tmuxinator
    tree
    unison
    unzip
    wget
    wireguard-tools
    yadm
    yq
    zip
  ];
}
