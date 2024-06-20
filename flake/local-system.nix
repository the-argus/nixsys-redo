# this function returns the attrset that is meant to be passed as the
# "localSystem" attribute when doing "import nixpkgs"
# this attrset usually only contains the system. but it can also include
# optimization and libc options.
{
  lib,
  system,
  arch,
  useArch,
  useMusl,
}:
{inherit system;}
// (lib.attrsets.optionalAttrs useMusl {
  libc = "musl";
  config = assert lib.asserts.assertMsg (system == "x86_64-linux") "musl only implemented for x86_64-linux"; "x86_64-unknown-linux-musl";
})
// (
  lib.attrsets.optionalAttrs useArch {
    gcc = {
      arch = arch;
      tune = arch;
    };
  }
)
