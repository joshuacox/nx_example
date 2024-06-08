{ config, lib, pkgs, ... }:
let
in
{
  programs.neovim = {
    enable = true;
    configure = {
      customRC = ''
        set number
        set cc=80
        set list
        set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
        if &diff
          colorscheme blue
        endif
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ ctrlp ];
      };
    };
  };
  environment.systemPackages = with pkgs; [ 
    lunarvim
    code-minimap
  ];
}
