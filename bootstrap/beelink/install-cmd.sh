#!/bin/sh
sudo PATH="$PATH:/usr/sbin:/sbin" NIX_PATH="$HOME/.nix-defexpr/channels" `which nixos-install` --root /mnt
