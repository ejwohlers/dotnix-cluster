_: {
  imports = [ ../modules/base.nix ];

  networking.hostName = "nova";
  networking.interfaces.enp0s31f6.useDHCP = true;

  networking.interfaces.enp0s31f6.ipv4.addresses = [{
    address = "192.168.1.102";
    prefixLength = 24;
  }];

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
 
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=512M" ];
  };

  system.stateVersion = "23.11";
}
