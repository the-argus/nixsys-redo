{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.desktops.sway;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    desktops.enable = true;
    desktops.wayland.enable = true;

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true; # so that gtk works properly
      extraPackages = [];
    };

    xdg.portal.extraPortals = with pkgs; [
      pkgs.xdg-desktop-portal-wlr
    ];

    # already done by enabling sway I believe but whatever
    programs.xwayland.enable = true;
  };
}
