{...}: {
  imports = [
    ./hardware.nix
    ./wayland.nix
    ./xorg.nix
    ./terminal.nix
    ./theme.nix
    ./desktops
  ];
}
