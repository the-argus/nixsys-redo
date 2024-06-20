{...}: {
  imports = [
    ./configuration.nix
    # NOTE: make-minimal disables redistributable firmware. install firmware in host specific hardware config
    ./make-minimal.nix
    ./solokey.nix
    ./issue
    ./packages.nix
    ./zsh.nix
  ];
}
