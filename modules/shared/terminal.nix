{
  lib,
  pkgs,
  ...
}: {
  options.desktops.terminal = mkOption {
    type = lib.types.package;
    default = pkgs.kitty;
  };
}
