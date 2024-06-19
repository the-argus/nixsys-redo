{
  lib,
  arch,
  useArch,
  compiler,
  llvmPackages,
}:
lib.attrsets.optionalAttrs (compiler != "gcc" || useArch) {
  replaceStdenv = {pkgs, ...}: let
    mkStdenv = march: stdenv:
      if useArch
      then (pkgs.withCFlags ["-march=${march}" "-mtune=${march}"] stdenv)
      else stdenv;

    optimizedStdenv = mkStdenv arch pkgs.stdenv;

    optimizedClangStdenv = mkStdenv arch pkgs.${llvmPackages}.stdenv;
  in (
    if compiler == "clang"
    then optimizedClangStdenv
    else if compiler == "gcc"
    then optimizedStdenv
    else throw "only clang and gcc are supported compilers"
  );
}
