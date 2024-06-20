{...}: {
  imports = [
    ./hardware.nix
    ./wayland.nix
    ./xorg.nix
    ./desktops
  ];
}
