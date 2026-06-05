{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.common = {
    imports = [
      self.nixosModules.core
      self.nixosModules.locale
      self.nixosModules.users
      self.nixosModules.packages
      self.nixosModules.networking
      self.nixosModules.services
      self.nixosModules.nixSettings
      self.nixosModules.preferences
      inputs.home-manager.nixosModules.home-manager
      inputs.nix-index-database.nixosModules.default
    ];
    programs.nix-index-database.comma.enable = true;
  };
}
