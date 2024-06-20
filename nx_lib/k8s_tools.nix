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
    kind
    kubectl
    kubectx
    kubecolor
    k9s
    krew
    kubernetes-helm
    operator-sdk
    minikube
    rakkess
    yaml2json
  ];
}
