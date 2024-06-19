{
  description = "the-argus nixos system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    banner.url = "github:the-argus/banner.nix";

    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gtk-nix = {
      url = "github:the-argus/gtk-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # non-nix imports (need fast updates):
    arkenfox-userjs = {
      url = "github:arkenfox/user.js";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    banner,
    spicetify-nix,
    gtk-nix,
    arkenfox-userjs,
  } @ inputs: let
    # this function imports the nixpkgs-inputs function to create the correct
    # inputs to import nixpkgs, based on a given settings attrset. these
    # attrsets are different per-host and are found in `flake/hosts`.
    mkNixOSConfig = settings:
      nixpkgs.lib.nixosSystem {
        pkgs = import nixpkgs (import ./flake/nixpkgs-inputs.nix settings);
        inherit (settings) system stateVersion;

        # make information accessible as module arguments
        specialArgs = inputs // {inherit (settings) username hostname stateVersion;};

        # settings.modules are defined in files such as hosts/laptop/top-level.nix
        # it is how other nixos configuration options are imported
        modules = [./hosts/defaults/configuration.nix ./modules/system] ++ settings.nixosModules;
      };
  in {
    nixosConfigurations = {
      laptop = mkNixOSConfig import ./hosts/laptop/top-level.nix;
    };
  };
}
