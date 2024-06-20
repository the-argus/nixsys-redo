{lib, ...}: {
  imports = [
    ./gnome.nix
    ./sway.nix
  ];

  options.desktops = {
    # this option is set by desktops: when a desktop is enabled, it enables this
    enable = lib.mkEnableOption "Set internally- do not use. Enable general dekstop related settings.";
  };
}
