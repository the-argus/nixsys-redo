{...}: {
  imports = [
    ./plymouth.nix
    ./wayland.nix
    ./xorg.nix
    ./emptty.nix
    ./terminal.nix
    ./desktops
  ];
}
