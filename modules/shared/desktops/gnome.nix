{lib, ...}: {
  options.desktops.gnome = {
    enable = lib.mkEnableOption "Gnome Desktop Environment";
  };
}
