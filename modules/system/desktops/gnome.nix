{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.desktops.gnome;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    desktops.enable = true;
    desktops.xorg.enable = true;
    desktops.wayland.enable = true;

    services.xserver.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    programs.dconf.enable = true;
    xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-gnome];

    # add gnome extensions
    environment.systemPackages = with pkgs.gnomeExtensions; [
      keep-awake
      no-titlebar-when-maximized
      # gtk-title-bar
      appindicator
      transparent-window-moving
      # compiz-alike-windows-effect
      # compiz-windows-effect
      # desktop-cube
      burn-my-windows
      blur-my-shell
      just-perfection
      dash-to-panel
      gesture-improvements
      fly-pie
    ];

    hardware.pulseaudio.enable = false;

    # fight nixos to remove all the extra packages i dont need
    environment.gnome.excludePackages =
      (with pkgs; [
        gnome-photos
        gnome-tour
        gnome-text-editor
        gnome-console
        gnome-usage
        gnome-connections
        gnome-secrets
        gnome-console
        baobab
        simple-scan
        yelp
      ])
      ++ (with pkgs.gnome; [
        rygel
        gnome-calculator
        gnome-logs
        gnome-disk-utility
        gnome-weather
        gnome-contacts
        gnome-clocks
        gnome-maps
        gnome-contacts
        nautilus
        gnome-terminal
        cheese # webcam tool
        gnome-music
        epiphany # web browser
        geary # email reader
        evince # document viewer
        gnome-characters
        totem # video player
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        baobab # disk usage analyzer
        file-roller
        gnome-calendar
        simple-scan
        gnome-font-viewer
        gnome-system-monitor
        yelp
        eog
        gnome-color-manager
      ]);
  };
}
