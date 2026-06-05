{ ... }:
{
  flake.nixosModules.packages =
    {
      pkgs,
      inputs,
      lib,
      config,
      ...
    }:
    let
      inherit (pkgs.stdenv.hostPlatform) system;
    in
    {
      environment.systemPackages = with pkgs; [
        libreoffice
        ffmpeg
        nixd
        nh
        waypipe
        wineWow64Packages.stable
        inputs.helium.packages.${system}.default
        gh
        git
        qt6.qtwayland
        openssl
        mpv
        eog
        kdePackages.ark
        kdePackages.dolphin
        pavucontrol
        pulseaudio
        adwaita-icon-theme
        p7zip
        unzip
        zip
      ];
    };
}
