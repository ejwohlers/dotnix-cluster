_: {
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  services.openssh.enable = true;
  users.users.ed = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword = "..."; # or null for passwordless + SSH only
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1..." # replace with your real SSH key
    ];
  };

  # Minimal packages
  environment.systemPackages = with pkgs; [ vim git curl ];

  networking.firewall.enable = false;
}
