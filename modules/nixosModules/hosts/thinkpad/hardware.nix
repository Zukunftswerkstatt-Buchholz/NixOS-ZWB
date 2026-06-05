{ ... }:
let
  hardwareModule =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.systemd.enable = true;
      boot.initrd.verbose = false;
      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [
        "nvme"
        "xhci_pci"
        "usb_storage"
      ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      boot.blacklistedKernelModules = [
        # Disable TPM
        # "tpm"
        # "tpm_tis"
        # "tpm_crb"
        # Disable Serial
        "8250"
        "8250_core"
        "8250_pci"
      ];

      boot.kernelParams = [
        "8250.nr_uarts=0"
      ];

      hardware.graphics.enable = true;
      hardware.graphics.enable32Bit = true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
in
{
  flake.nixosModules.thinkpadHardware = hardwareModule;
}
