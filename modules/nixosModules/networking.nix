{...}: {
  flake.nixosModules.networking = {lib, ...}: {
    networking.networkmanager.enable = true;
    systemd.services.NetworkManager-wait-online.enable = false;
    services.resolved.enable = true;
  };
}
