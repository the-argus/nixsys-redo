# top-level settings for laptop (stuff that matters before nixpkgs has been
# imported)
{
  system = "x86_64-linux";
  allowedUnfree = [];
  permittedInsecurePackages = [];
  allowBroken = false;
  arch = "tigerlake";
  useMusl = false;
  useArch = false;
  compiler = "gcc";
  # the version nixos was installed at
  stateVersion = "22.11";
  username = "argus";
  hostname = "evil";
  # this file overrides defaults defined in hosts/defaults
  nixosModules = [./system ./shared];
}
