# NixOS and home-manager config

My config. The `configuration.nix` and other nixos modules are all in `hosts/defaults/system/`.
Per-machine overrides (firmware, hard drive and filesystem information, username,
hostname, etc) are in `hosts/<name>/system/`. The same goes for home-manager, except
it's in the `user/` subdirectory instead of `system/`.

Each machine (host) has "top level" options. These are settings that need to be
known before nixpkgs is imported and therefore cannot be contained in a nixpkgs
module. These options include hostname, primary username, system, architecture,
whether to compile for musl libc, and whether to optimize for the host's architecture.
They are found in `hosts/<name>/top-level.nix`.

## TODO

- Make dunst icons work. Currently they use a `/usr/share` FHS path, that needs
  to be set to whatever the NixOS equivalent is.
- Fix emptty module so that it doesn't log me out whenever the service is restarted
  (which happens which I `nixos-rebuild`)
- Look into configuring/styling `fzf` so its colors match my theme.
- Fix xdg-open to properly open files of different types in my desired programs
  - Remove `rifle`, the python script that does this for ranger, from `lf.nix` and
    from `packages/`
- Enable webGL and history for firefox, being secure is too tiring and I just use
  ungoogled chromium all the time instead
- Figure out why firefox takes so long to start, I'm pretty sure it's my config.
  - Maybe just switch to ungoogled chromium though :/
