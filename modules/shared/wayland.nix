{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.desktops.wayland = {
    enable = mkEnableOption "Wayland Display";
  };
}
