_: {
  networking.hostName = "vega";

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=512M" ];
  };

  system.stateVersion = "23.11";
}
