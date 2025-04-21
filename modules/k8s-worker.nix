# modules/k8s-worker.nix
{ config, pkgs, lib, ... }: {

  services.k3s.enable = true;
  services.k3s.role = "agent";
  services.k3s.serverAddr = "https://192.168.1.100:6443";

  services.k3s.tokenFile = config.sops.secrets.k3sToken.path;

  networking.firewall.allowedTCPPorts = [ 10250 ];

  environment.systemPackages = with pkgs; [
    kubectl
  ];
}
