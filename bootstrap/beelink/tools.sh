#!/bin/sh
nix-channel --add https://nixos.org/channels/nixos-23.11 nixpkgs 
nix-channel --update && nix-channel --list
nix-env -f '<nixpkgs>' -iA nixos-install-tools
