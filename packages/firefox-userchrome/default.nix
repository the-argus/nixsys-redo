{
  callPackage,
  # "top-level" because it exists before these packages get callPackage'd
  top-level-firefox-assets,
  ...
}: {
  # creates userChrome strings based on input
  # requires two arguments: font (font name string), and colors (parsed banner color scheme)
  mkOriginal = import ./original.nix {firefox-assets = top-level-firefox-assets;};
  # args:
  # useSideView : bool
  # useTabCenterVerticalTabs : bool
  # useDefaultColors : bool
  # colors: parsed banner color scheme
  mkCascade = callPackage ./cascade;
}
