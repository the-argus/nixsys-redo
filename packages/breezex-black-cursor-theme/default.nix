{stdenvNoCC, ...}:
stdenvNoCC.mkDerivation rec {
  name = "BreezeXBlack";
  src = builtins.fetchTarball {
    url = "https://github.com/ful1e5/BreezeX_Cursor/releases/download/v1.0.3/BreezeX-Black.tar.gz";
    sha256 = "sha256:10sj6fmpxs8509lpjz7pj0iyahi29fn206m2lr5sv1ks9g6hnav4";
  };
  installPhase = ''
    mkdir $out/share/icons/${name} -p
    cp -r $src/* $out/share/icons/${name}
  '';
}
