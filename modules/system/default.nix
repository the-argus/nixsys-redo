{...}: {
  imports = [
    ./plymouth.nix
    ./wayland.nix
    ./xorg.nix
    ./desktops
  ];
}
