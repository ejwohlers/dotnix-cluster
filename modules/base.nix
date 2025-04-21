{ config, pkgs, lib, ... }:

{
  imports = [ ];

  networking.hostName = lib.mkDefault "changeme"; # Will be overridden by each host

  time.timeZone = "America/Bogota"; # Adjust if needed
  i18n.defaultLocale = "en_US.UTF-8";

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "prohibit-password";
    settings.PasswordAuthentication = false;
  };

  users.users.root = {
    openssh.authorizedKeys.keys = [
      # Replace with your actual public key!
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ..."
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "23.11";
}
