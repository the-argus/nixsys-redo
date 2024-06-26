{
  pkgs,
  banner,
  ...
}: rec {
  plymouth-themes = pkgs.callPackage ./plymouth-themes {};
  firefox-assets = pkgs.callPackage ./firefox-assets {};
  firefox-userchrome = pkgs.callPackage ./firefox-userchrome {
    top-level-firefox-assets = firefox-assets;
  };
  color-schemes = import ./color-schemes {inherit banner;};
  neovim-remote = pkgs.callPackage ./neovim-remote {};
  picom = pkgs.callPackage ./picom {};
  xgifwallpaper = pkgs.callPackage ./xgifwallpaper {};
  ufetch = pkgs.callPackage ./ufetch {};
  godot_4_mono-bin = pkgs.callPackage ./godot_4_mono-bin {};
  material-black-frost-gtk-theme = pkgs.callPackage ./material-black-frost-gtk-theme {};
  nordarc-nordzy-icon-theme = pkgs.callPackage ./nordarc-nordzy-icon-theme {};
  posys-improved-cursor-theme = pkgs.callPackage ./posys-improved-cursor-theme {};
  google-dot-black-cursor-theme = pkgs.callPackage ./google-dot-black-cursor-theme {};
  breezex-black-cursor-theme = pkgs.callPackage ./breezex-black-cursor-theme {};
  emptty-unwrapped = pkgs.callPackage ./emptty/default.nix {};
  emptty = pkgs.callPackage ./emptty/wrapper.nix {inherit emptty-unwrapped;};
  rifle = pkgs.callPackage ./rifle {};

  # themes are a collection of many other packages
  system-themes = pkgs.callPackage ./system-themes {
    top-level-color-schemes = color-schemes;
    top-level-material-black-frost-gtk-theme = material-black-frost-gtk-theme;
    top-level-nordarc-nordzy-icon-theme = nordarc-nordzy-icon-theme;
    top-level-posys-improved-cursor-theme = posys-improved-cursor-theme;
    top-level-google-dot-black-cursor-theme = google-dot-black-cursor-theme;
    top-level-breezex-black-cursor-theme = breezex-black-cursor-theme;
  };
}
