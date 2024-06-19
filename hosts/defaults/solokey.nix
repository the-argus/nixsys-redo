{...}: {
  services.udev.extraRules = ''    ACTION!="add|change", GOTO="solokeys_end"
    # SoloKeys rule

    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="a2ca", TAG+="uaccess"

    LABEL="solokeys_end"'';

  security.pam.u2f.enable = true;

  security.pam.services.login.text = lib.mkDefault (lib.mkBefore ''
    auth sufficient pam_u2f.so
  '');

  security.pam.services.sudo.text = pkgs.lib.mkDefault (pkgs.lib.mkBefore ''
    auth sufficient pam_u2f.so
  '');
}
