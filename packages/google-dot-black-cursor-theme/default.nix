{stdenvNoCC, ...}:
stdenvNoCC.mkDerivation rec {
  name = "GoogleDotBlack";
  src = builtins.fetchTarball {
    url = "https://github.com/ful1e5/Google_Cursor/releases/download/v1.1.3/GoogleDot-Black.tar.gz";
    sha256 = "sha256:0kn49c99vk28iijrwp8cnv98sac3pb3jrk6pn12l3ws8q269363f";
  };
  installPhase = ''
    mkdir $out/share/icons/${name} -p
    cp -r $src/* $out/share/icons/${name}
  '';
}
