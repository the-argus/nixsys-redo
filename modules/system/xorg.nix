{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.desktops.xorg;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      excludePackages = with pkgs; [
        xterm
        xorg.xf86inputevdev.out
      ];
    };

    environment.systemPackages = with pkgs; [
      feh
      xclip
      xcolor
      xorg.xauth
      xorg.xf86inputsynaptics
      xorg.xf86inputmouse
    ];
  };
}
