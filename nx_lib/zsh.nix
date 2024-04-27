{ config, lib, pkgs, ... }:
let
in
{
  programs.zsh.enable = true;
  environment.shells = with pkgs; [
    zsh
  ];
  environment.systemPackages = with pkgs; [ 
    zsh
    zsh-completions
    zsh-powerlevel10k
    zsh-syntax-highlighting
    zsh-history-substring-search
  ];
}
