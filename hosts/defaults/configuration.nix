{
  pkgs,
  lib,
  username,
  stateVersion,
  default-system-features,
  ...
}: {
  imports = [
    ./solokey.nix
    ./issue
    ./packages.nix
    ./zsh.nix
  ];

  environment.variables.EDITOR = lib.mkDefault "nvim";

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  console = {
    font = lib.mkDefault "Lat2-Terminus16";
    keyMap = lib.mkDefault "us";
  };

  nix = {
    package = lib.mkDefault pkgs.nixVersions.stable;
    # these are not marked mkDefault because I can't see any reason they would
    # change per host, unless a mistake was made
    settings = {
      extra-experimental-features = ["nix-command" "flakes"];
      substituters = [
        "https://cache.nixos.org/"
      ];
      auto-optimise-store = true;
      # good default system features which include the stuff needed to show that
      # we can run stuff compiled specifically for our architecture
      system-features = lib.mkDefault default-system-features;
    };
  };

  # free storage space by removing documentation
  documentation = {
    info.enable = lib.mkDefault false;
    dev.enable = lib.mkDefault false;
    nixos.enable = lib.mkDefault false;
  };

  # most options for the user here are not marked mkDefault, no reason for them
  # to change per host, more groups is always better in my case :)
  # shell is not set to zsh because that is determined by the defaultUserShell
  # option, in zsh.nix
  users.users.${username} = {
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

  # not marked mkDefault because it is already determined by host option
  system.stateVersion = stateVersion;
}
