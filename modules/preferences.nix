{...}: {
  flake.nixosModules.preferences = {
    lib,
    config,
    ...
  }: {
    options.local = {
      username = lib.mkOption {
        type = lib.types.str;
        default = "zwb";
        description = "username for the primary user";
      };

      homeDirectory = lib.mkOption {
        type = lib.types.str;
        default = "/home/${config.local.username}";
        description = "home directory";
      };

      flakePath = lib.mkOption {
        type = lib.types.str;
        default = "/config";
      };
    };

    options.theme = {
      wallpaper = lib.mkOption {
        type = lib.types.path;
        default = builtins.path {
          path = /config/assets/wallpapers/default.heic;
          name = "default-wallpaper.heic";
        };
        description = "Wallpaper";
      };
    };
  };
}
