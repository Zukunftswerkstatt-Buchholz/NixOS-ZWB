{
  self,
  inputs,
  ...
}: let
  nixpkgsConfig = {
    allowUnfree = true;
  };
in {
  flake.nixosModules.thinkpad = {
    pkgs,
    inputs,
    config,
    ...
  }: {
    imports = [
      self.nixosModules.thinkpadHardware
      self.nixosModules.thinkpadDisk
      self.nixosModules.common
    ];

    nixpkgs = {
      config = nixpkgsConfig;
    };

    networking.hostName = "thinkpad";
    networking.networkmanager.wifi.powersave = true;

    services.power-profiles-daemon.enable = false;
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      };
    };

    services.thermald.enable = true;

    system.stateVersion = "25.11";
  };

  flake.nixosConfigurations.thinkpad = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs self;};
    modules = [self.nixosModules.thinkpad];
  };
}
