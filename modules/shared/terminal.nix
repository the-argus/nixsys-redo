{
  lib,
  pkgs,
  ...
}: {
  options.desktops.terminal = lib.mkOption {
    type = lib.types.package;
    default = pkgs.kitty;
  };
}
