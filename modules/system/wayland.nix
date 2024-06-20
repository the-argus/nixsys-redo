# Settings that should be enabled if there's any wayland graphical sessions
# installed
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.desktops.wayland;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    xdg = {
      portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard
      wlsunset
      grim
      slurp
      imv
    ];
  };
}
