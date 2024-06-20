{
  callPackage,
  banner,
  ...
}: {
  amber-forest = callPackage ./amber-forest {inherit banner;};
  drifter = callPackage ./drifter {inherit banner;};
  gruvbox = callPackage ./gruvbox {inherit banner;};
  nord = callPackage ./nord {inherit banner;};
  rosepine = callPackage ./rosepine {inherit banner;};
}
