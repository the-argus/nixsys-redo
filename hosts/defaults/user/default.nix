{...}: {
  imports = [
    ./blugon.nix
    ./dunst.nix
    ./firefox.nix
    ./git.nix
    ./gtk.nix
    # installs kitty (already done by config.desktops.terminal in nixos config) and optionally the system theme font (also already done)
    ./kitty.nix
    # some package footprint because the lf config uses a bunch of CLI utilities
    ./lf.nix
    ./rofi.nix
    # pretty big package footprint since it installs all the extensions + custom apps
    ./spicetify.nix
    # installs waybar and the config files for it
    ./waybar.nix
    # puts the contents of config.system.theme.discordTheme into ~/.config/WebCord/Themes
    ./webcord.nix
    # just generates a zathurarc, doesn't install zathura
    ./zathura.nix
  ];
}
