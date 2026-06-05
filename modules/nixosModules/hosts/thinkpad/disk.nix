{inputs, ...}: let
  luksPartitionLabel = "cryptroot";
  luksMapperName = "thinkpad-crypt";
  diskModule = {lib, ...}: {
    imports = [
      inputs.disko.nixosModules.disko
    ];

    disko.devices.disk.main = {
      type = "disk";
      device = "usb-USB_SanDisk_3.2Gen1_010183b392c8df30f20e70dd3d5d4cfcd8979d2296e476e34b2d423226fe25c65547000000000000000000003817691c00877400815581076c2c25c5-0:0";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            type = "EF00";
            size = "500M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
            };
          };
          "${luksPartitionLabel}" = {
            size = "100%";
            name = luksPartitionLabel;
            content = {
              type = "luks";
              name = luksMapperName;
              settings = {
                allowDiscards = true;
                # passwordFile = "/tmp/disko-passphrase"; # Provide a path for unattended unlocks
              };
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "/" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/nix/store" = {
                    mountpoint = "/nix/store";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/var/log" = {
                    mountpoint = "/var/log";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };

    boot.initrd.luks.devices.${luksMapperName} = {
      device = "/dev/disk/by-partlabel/disk-main-${luksPartitionLabel}";
      allowDiscards = true;
      # keyFile = "/etc/keys/${luksMapperName}.key"; # Pair with boot.initrd.secrets when using key files
    };
  };
in {
  flake.nixosModules.thinkpadDisk = diskModule;
}
