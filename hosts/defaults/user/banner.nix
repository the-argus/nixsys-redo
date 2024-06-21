# This essentially just makes config.system.theme.scheme available as
# config.banner.palette.
{
  banner,
  config,
  ...
}: {
  imports = [
    banner.module
  ];
  banner.palette = config.system.theme.scheme;
}
