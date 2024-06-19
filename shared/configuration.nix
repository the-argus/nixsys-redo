# This file contains configuration options which are absolutely 100% shared and
# the same between all hosts. There isn't a simple way to make defaults happen
# (mark everything with lib.lowPrio?) so if something becomes specific to
# a certain host, it would have to be moved out of this file to *all* host
# configurations
{
  pkgs,
  lib,
  username,
  stateVersion,
  settings,
  ...
}: {
  imports = [
    ./solokey.nix
    ./issue
    ./packages.nix
    ./zsh.nix
  ];

  environment.variables.EDITOR = "nvim";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkDefault "us";
  };

  nix = {
    package = lib.mkDefault pkgs.nixVersions.stable;
    settings = {
      extra-experimental-features = ["nix-command" "flakes"];
      substituters = [
        "https://cache.nixos.org/"
      ];
      auto-optimise-store = true;
    };
  };

  # free storage space by removing documentation
  documentation = {
    info.enable = false;
    dev.enable = false;
    nixos.enable = false;
  };

  users.users.${username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    initialPassword = "password123";
    extraGroups = [
      "davfs2"
      "wheel"
      "video"
      "audio"
      "jackaudio"
      "systemd-network"
      "networkmanager"
      "openrazer"
      "plugdev"
      "libvirtd"
    ];
  };

  system.stateVersion = stateVersion;
}
