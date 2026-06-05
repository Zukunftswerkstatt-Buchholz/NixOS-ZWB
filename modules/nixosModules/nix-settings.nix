{...}: {
  flake.nixosModules.nixSettings = {
    inputs,
    pkgs,
    config,
    ...
  }: {
    nixpkgs.overlays = [
      (final: prev: {
        inherit
          (prev.lixPackageSets.stable)
          nixpkgs-review
          nix-eval-jobs
          nix-fast-build
          colmena
          ;
      })
    ];

    nix = {
      package = pkgs.lix;
      registry.nixpkgs.flake = inputs.nixpkgs;
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];

      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 15d";
      };
      optimise = {
        automatic = true;
        dates = ["daily"];
      };
      settings = {
        cores = 0; # Use all available cores
        max-jobs = "auto";
        connect-timeout = 3;
        fallback = true;
        max-substitution-jobs = 4;
        http-connections = 10;
        trusted-users = ["root"];
        experimental-features = [
          "nix-command"
          "flakes"
          "lix-custom-sub-commands"
        ];
      };
    };
  };
}
