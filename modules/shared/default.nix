{...}: {
  imports = [
    ./hardware.nix
    ./wayland.nix
    ./xorg.nix
    ./terminal.nix
    ./desktops
  ];
}
