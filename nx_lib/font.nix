{pkgs, lib, config, ...}:
with lib;
with builtins;
let
in {
  config = {
    # bigger tty fonts
    console.font =
      "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    fonts = {
      fontDir.enable = true;
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        liberation_ttf
        nerdfonts
        fira-code
        fira-code-symbols
        mplus-outline-fonts.githubRelease
        dina-font
        proggyfonts
      ];
    };
    #fonts.fonts = with pkgs; [ nerdfonts ];
  };
}
