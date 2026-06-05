{...}: {
  flake.nixosModules.users = {
    pkgs,
    config,
    inputs,
    ...
  }: let
    username = config.local.username;
  in {
    environment.pathsToLink = ["/share/fish"];
    programs.fish.enable = true;

    users.groups.${username}.gid = 1000;
    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "disk"
        "networkmanager"
        "wheel"
        username
        "audio"
        "pipewire"
      ];
      shell = pkgs.fish;
      hashedPassword = "$y$j9T$kzm9BvjVyczJhgW8S2Zn9.$nekN9LXMsq/Wn13ttWM4AU8yk7o1pGKH3BgAcBWUvJ7";
    };

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = { inherit inputs; };
    home-manager.users.${username} = {
      home.username = username;
      home.homeDirectory = config.local.homeDirectory;
      home.stateVersion = "25.11";
      home.file."ligma.sh".text = "echo 'Hello, world!'";
    };
  };
}
