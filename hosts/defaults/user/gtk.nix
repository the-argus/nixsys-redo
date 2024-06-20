# This file configures the gtk theme, based on options set in
# config.system.theme.
# Includes some hardcoded values:
# - disabled-opacity of gtk theme does not follow config.system.theme
#   - I think I did this to fix the window titlebar buttons not really being
#     visible?
# - corner radius is hardcoded to be 8px
#
# It also includes the highlighted directories that appear in gtk file explorers
{
  pkgs,
  homeDirectory,
  gtk-nix,
  config,
  ...
}: let
  gtk = config.system.theme.gtk;
  isGtkNix =
    if builtins.typeOf gtk.theme == "string"
    then gtk.theme == "gtkNix"
    else throw "gtk.theme cannot be a string if it's not \"gtkNix\"";
in {
  imports = [gtk-nix.homeManagerModule];
  home.packages = [pkgs.dconf];
  home.file = {
    # xorg cursor
    ".icons/default/index.theme" = {
      text = ''
        [Icon Theme]
        Inherits=${gtk.cursorTheme.name}
      '';
    };
  };

  gtkNix =
    pkgs.lib.mkIf isGtkNix
    {
      enable = true;
      configuration = {
        radius = "8px";
        disabled-opacity = 0.6;
      };
      palette = config.banner.palette;
    };

  gtk = {
    enable = true;

    font = config.system.theme.font.display;

    cursorTheme = gtk.cursorTheme;

    iconTheme = gtk.iconTheme;

    theme = pkgs.lib.mkIf isGtkNix gtk.theme;

    gtk3 = {
      bookmarks = [
        "file://${homeDirectory}/Downloads"
        "file://${homeDirectory}/Programming"
        "file://${homeDirectory}/Video"
        "file://${homeDirectory}/Music"
        "file://${homeDirectory}/Screenshots"
        "file://${homeDirectory}/Wallpapers"
      ];
    };
  };
}
