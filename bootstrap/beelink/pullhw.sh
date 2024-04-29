#!/bin/sh
. ./.target
scp root@$TARGET:/mnt/etc/nixos/hardware-configuration.nix ./
