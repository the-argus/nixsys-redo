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
  color-schemes = pkgs.callPackage ./color-schemes {inherit banner;};
  neovim-remote = pkgs.callPackage ./neovim-remote {};
  picom = pkgs.callPackage ./picom {};
  xgifwallpaper = pkgs.callPackage ./xgifwallpaper {};
  ufetch = pkgs.callPackage ./ufetch {};
}
