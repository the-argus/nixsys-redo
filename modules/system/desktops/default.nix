{lib, ...}: {
  imports = [
    ./gnome.nix
    ./sway.nix
  ];

  # settings that should be enabled if even one graphical session is installed
  config = lib.mkIf config.desktops.enable {
    services.libinput = {
      enable = true;
      touchpad.naturalScrolling = false;
      touchpad.middleEmulation = true;
      touchpad.tapping = true;
      mouse.accelProfile = "flat";
    };
  };
}
