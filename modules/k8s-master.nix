_: {
  environment.systemPackages = with pkgs; [
    kubectl
    helm
    k9s
    # add any infra tools here
  ];

  networking.hosts = {
    # Static HA discovery map (customize with your IPs)
    "192.168.1.101" = [ "orion" ];
    "192.168.1.102" = [ "vega" ];
    "192.168.1.103" = [ "nova" ];
  };

  system.stateVersion = "23.11"; # or whatever matches your system
}