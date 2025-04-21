# modules/secrets.nix
{ config, lib, pkgs, ... }: {
  sops.defaultSopsFile = ../secrets/k3s-token.yaml;

  sops.secrets.k3sToken = {
    owner = "root";
    mode = "0400";
    path = "/etc/rancher/k3s/token";
  };
}
