# This is the nixos-side implementation of the config.desktops.terminal option.
# all it does is install the terminal package systemwide, IF a graphical session
# is installed.
{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.desktops.enable {
    environment.systemPackages = [config.desktops.terminal];
  };
}
