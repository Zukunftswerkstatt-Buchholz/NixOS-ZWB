{ ... }:
{
  flake.nixosModules.services =
    { ... }:
    {
      services.gvfs.enable = true;
      services.printing.enable = true;
      services.gnome.gnome-keyring.enable = false;
      services.thermald.enable = true;
      hardware.bluetooth.enable = true;

      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
         
      security.rtkit.enable = true; # lets PipeWire request real-time priority

      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };
}
