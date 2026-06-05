{lib, ...}: {
  options.flake.lib.homeModules = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.anything;
    default = {};
    description = ''
      home modules
    '';
  };

  config.systems = ["x86_64-linux"];
}
