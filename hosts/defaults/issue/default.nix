# NOTE: in order to override this particular option, it is necessary to use
# lib.mkForce. a high priority had to be used for this default since nixOS
# already defines an etc/issue
{
  pkgs,
  lib,
  username,
  ...
}: {
  environment.etc.issue.source =
    lib.mkOverride 51 (pkgs.writeText "issue"
      (import ./braille-large-welcome.nix {inherit username;}));
}
