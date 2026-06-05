{...}: {
  flake.nixosModules.core = {
    lib,
    pkgs,
    ...
  }: {
    boot = {
      supportedFilesystems = ["ext4" "ntfs" "vfat" "exfat"];
      kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        efi.efiSysMountPoint = "/boot";
      };
    };
  };
}
