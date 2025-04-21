{ config, pkgs, lib, ... }: {

  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = ''
      --write-kubeconfig-mode 644
      --disable traefik
    '';
  };

  networking.firewall.allowedTCPPorts = [ 6443 10250 ];

  environment.systemPackages = with pkgs; [
    kubectl
    helm
    k9s
  ];

  networking.hosts = {
    "192.168.1.100" = [ "orion" ];
    "192.168.1.101" = [ "vega" ];
    "192.168.1.102" = [ "nova" ];
  };

  system.stateVersion = "23.11";
}
