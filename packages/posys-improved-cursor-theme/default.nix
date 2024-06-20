# This theme includes:
# Posy_Cursor
# Posy_Cursor_125_175
# Posy_Cursor_Black
# Posy_Cursor_Black_125_175
# Posy_Cursor_Mono
# Posy_Cursor_Mono_Black
# Posy_Cursor_Strokeless
{
  stdenvNoCC,
  fetchgit,
  # this can be 125_175, Black, Mono, Strokeless, etc
  variant ? "",
  ...
}: let
  name =
    if variant == ""
    then "Posy_Cursor"
    else "Posy_Cursor_${variant}";
in
  stdenvNoCC.mkDerivation {
    inherit name;
    version = "1.6-unstable";
    src = fetchgit {
      url = "https://github.com/simtrami/posy-improved-cursor-linux";
      hash = "sha256-ndxz0KEU18ZKbPK2vTtEWUkOB/KqA362ipJMjVEgzYQ=";
      rev = "bd2bac08bf01e25846a6643dd30e2acffa9517d4";
    };
    installPhase = ''
      mkdir $out/share/icons/${name} -p
      cp -r $src/${name}/* $out/share/icons/${name}
    '';
  }
