{
  buildGoModule,
  fetchFromGitHub,
  lib,
  libX11,
  pam,
  pam_u2f,
  stdenv,
  wayland,
  noX11 ? false,
  noU2f ? false,
}:
buildGoModule rec {
  pname = "emptty";
  version = "0.12.1";

  src = fetchFromGitHub {
    owner = "tvrzna";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-9qNAQBmcFKPpJ+AqfOy3emA1fvqI/XaT39KwI5fpXHU=";
  };

  buildInputs =
    [wayland pam]
    ++ (lib.lists.optionals (!noX11) [libX11])
    ++ (lib.lists.optionals (!noU2f) [pam_u2f]);

  vendorHash = "sha256-PLyemAUcCz9H7+nAxftki3G7rQoEeyPzY3YUEj2RFn4=";

  tags = lib.lists.optionals noX11 ["noxlib"];

  buildPhase = ''
    runHook preBuild
    make build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    make DESTDIR=$out install
    make DESTDIR=$out install-manual
    # make DESTDIR=$out install-systemd

    if [ -d $out/usr ]; then
      mv $out/usr/* $out
      rmdir $out/usr
    fi

    runHook postInstall
  '';

  meta = with lib; {
    description = "Dead simple CLI Display Manager on TTY";
    homepage = "https://github.com/tvrzna/emptty";
    license = licenses.mit;
    maintainers = with maintainers; [urandom];
    # many undefined functions
    broken = stdenv.isDarwin;
  };
}
