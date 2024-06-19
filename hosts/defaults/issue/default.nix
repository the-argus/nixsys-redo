{username, ...}: {
  environment.etc.issue.source =
    lib.mkForce (pkgs.writeText "issue"
      (import ./braille-large-welcome.nix {inherit username;}));
}
