{...}: {
  imports = [
    ./hardware.nix
  ];

  desktops = {
    gnome.enable = true;
    sway.enable = true;
  };
}
