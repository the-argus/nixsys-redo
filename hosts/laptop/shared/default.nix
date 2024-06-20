{pkgs, ...}: {
  imports = [
    ./hardware.nix
  ];

  desktops = {
    gnome.enable = true;
    sway.enable = true;
  };

  system.theme = pkgs.myPackages.themes.rosepineWithoutGtkNix;
}
