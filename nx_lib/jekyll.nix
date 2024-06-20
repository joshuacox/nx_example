{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    ruby
    rubyPackages.jekyll
    rubyPackages.jekyll-redirect-from
    rubyPackages.github-pages
    rubyPackages.jekyll-feed
  ];
}
