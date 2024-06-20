{ config, lib, pkgs, ... }:
let
in
{
  programs.neovim = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [ 
    lunarvim
    code-minimap
    lua51Packages.telescope-nvim
    vimPlugins.null-ls-nvim
    vimPlugins.none-ls-nvim
  ];
}
