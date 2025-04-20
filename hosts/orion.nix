_: {
  networking.hostName = "orion";

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ]; # prevent writing to real disk

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=512M" ];
  };

  system.stateVersion = "23.11";
}
