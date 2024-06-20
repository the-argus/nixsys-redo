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
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    banner,
    spicetify-nix,
    gtk-nix,
    arkenfox-userjs,
  } @ inputs: let
    importNixpkgs = np: settings: import np (import ./flake/nixpkgs-inputs.nix (settings // {lib = np.lib;}));
    # this function imports the nixpkgs-inputs function to create the correct
    # inputs to import nixpkgs, based on a given settings attrset. these
    # attrsets are different per-host and are found in `flake/hosts`.
    mkNixOSConfig = top-level:
      nixpkgs.lib.nixosSystem {
        pkgs = importNixpkgs nixpkgs top-level;
        inherit (top-level) system;

        # make information accessible as module arguments
        specialArgs =
          # all the flakes we're importing should be accessible
          inputs
          # import nixpkgs again, this time use unstable as the source. this way
          # modules can use the newer versions of packages
          // {unstable = importNixpkgs nixpkgs-unstable top-level;}
          # some stuff from top-level.nix should be accessible, mostly used
          # by the hosts/defaults/configuration.nix for stuff like users
          // {inherit (top-level) username hostname stateVersion;}
          # default-system-features is used by hosts/defaults/configuration.nix
          # to mkDefault. all my machines have the same system features so I never
          # actually have to override this default. the gccarch- option is needed
          # if top-level.useArch is true, otherwise nix thinks the host cant
          # run the binaries we are asking it to compile for its arch
          // {default-system-features = ["nixos-test" "benchmark" "big-parallel" "kvm" "gccarch-${top-level.arch}"];};

        # top-level.modules are defined in files such as hosts/laptop/top-level.nix
        # it is how other nixos configuration options are imported
        modules = [./hosts/defaults/configuration.nix ./modules/shared ./modules/system] ++ top-level.nixosModules;
      };
  in {
    nixosConfigurations = {
      laptop = mkNixOSConfig (import ./hosts/laptop/top-level.nix);
    };
  };
}
