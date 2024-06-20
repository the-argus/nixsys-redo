{
  pkgs,
  lib,
  ...
}: {
  options.system.theme = lib.mkOption {
    type = lib.types.attrs;
    default = pkgs.myPackages.system-themes.defaultTheme;
  };
}
