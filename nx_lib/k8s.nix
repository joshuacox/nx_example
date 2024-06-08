{ config, lib, pkgs, ... }:
let
in
{
  environment.systemPackages = with pkgs; [ 
    argocd
    argocd-autopilot
    argocd-vault-plugin
    gettext
    istioctl
    jinja2-cli
    kubectl
    kubectx
    kubecolor
    k9s
    krew
    kubernetes-helm
    rakkess
    yaml2json
  ];
}
