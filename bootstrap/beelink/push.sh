#!/bin/sh
. ./.target
tar zcf - *.nix | ssh root@$TARGET 'cd /mnt/etc/nixos;tar zxvpf -'
