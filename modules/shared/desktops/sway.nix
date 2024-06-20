{lib, ...}: {
  options.desktops.sway = {
    enable = lib.mkEnableOption "Sway Window Manager";
  };
}
