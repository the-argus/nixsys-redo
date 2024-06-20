{...}: {
  imports = [
    ./plymouth.nix
    ./wayland.nix
    ./xorg.nix
    ./emptty.nix
    ./desktops
  ];
}
