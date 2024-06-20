{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.desktops.xorg = {
    enable = mkEnableOption "X.org Display Server";
  };
}
