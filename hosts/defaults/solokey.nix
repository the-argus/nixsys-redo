# NOTE: these options are not marked as defaults because you don't want to
# accidentally change one and not the others.
# TODO: make a module for this
{
  lib,
  pkgs,
  ...
}: {
  services.udev.extraRules = ''    ACTION!="add|change", GOTO="solokeys_end"
    # SoloKeys rule

    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="a2ca", TAG+="uaccess"

    LABEL="solokeys_end"'';

  security.pam.u2f.enable = true;

  security.pam.services.login.text = lib.mkBefore ''
    auth sufficient pam_u2f.so
  '';

  security.pam.services.sudo.text = pkgs.lib.mkBefore ''
    auth sufficient pam_u2f.so
  '';
}
