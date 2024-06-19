# This is a function that returns the stuff that should be passed when doing
# "import nixpkgs ..."
# It handles:
# - overlays
# - replacing the stdenv with one that uses a different compiler
# - replacing libc with musl libc, if necessary
{
  lib,
  system ? "x86_64-linux",
  allowedUnfree ? [],
  permittedInsecurePackages ? [],
  allowBroken,
  # string, like "tigerlake"
  arch,
  useMusl ? false,
  useArch ? false,
  compiler ? "gcc", # can also be "clang"
  llvmPackages ? "llvmPackages_18",
  ...
}: {
  config =
    # first part of config handles broken, insecure, and unfree package allowances
    {
      inherit allowBroken permittedInsecurePackages;
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowedUnfree;
    }
    # this will replace the stdenv if compiler is not gcc
    // (import ./replace-stdenv.nix {inherit lib arch useArch compiler llvmPackages;});

  localSystem = import ./local-system.nix {inherit system arch useMusl useArch;};

  overlays = [];
}
