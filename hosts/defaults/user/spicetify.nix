# Use spicetify-nix to give spicetify a custom color scheme based on
# config.system.theme.scheme However the actual theme that is used is configured
# here, not in config.system.theme.
{
  pkgs,
  spicetify-nix,
  config,
  ...
}: let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in {
  # import the flake's module
  imports = [spicetify-nix.homeManagerModule];

  # configure spicetify :)
  programs.spicetify = rec {
    spicetifyPackage = pkgs.spicetify-cli;
    enable = true;
    theme = spicePkgs.themes.Onepunch;
    colorScheme = "custom";

    customColorScheme = let
      center = with config.system.theme.scheme; {
        text = hialt2;
        bg = base00;
      };
      outer = with config.system.theme.scheme; {
        text = hialt2;
        bg = base02;
      };
    in
      with config.system.theme.scheme; (
        if theme == spicePkgs.themes.Dribbblish
        then {
          text = center.text;
          subtext = center.text; # "F0F0F0";
          sidebar-text = outer.text; # use altfg if going for contrast on dribbs
          main = center.bg;
          sidebar = outer.bg; # and altbg here
          player = base00;
          card = base00;
          shadow = base02;
          selected-row = base02; # "797979";
          button = highlight;
          button-active = highlight;
          button-disabled = base03;
          tab-active = highlight;
          notification = base01; # "1db954";
          notification-error = urgent;
          misc = base04;
        }
        else if theme == spicePkgs.themes.Flow
        then {
          text = base05;
          gradientTop = base04;
          gradientBottom = base01;
          main = base03;
          subtext = base06;
          button-active = base03;
          button = base02;
          sidebar = base01;
          player = base07; # the player on the right side and also the play button
          card-background = base02;
          shadow = base00;
          notification = highlight;
          notification-error = urgent;
          card-hover = hialt0;
        }
        else if theme == spicePkgs.themes.Onepunch
        then {
          text = base05;
          subtext = base0B;
          extratext = base0A;
          main = base00; # all base00s were originally 1d2021
          sidebar = base00;
          player = base00;
          sec-player = base01; # all base01s were originally 32302f
          card = base01;
          sec-card = base08;
          shadow = base00;
          selected-row = highlight; # originally purple/base0E
          button = hialt0; # originally cyan/base0C
          button-active = hialt0;
          button-disabled = base03;
          tab-active = base08;
          notification = base08;
          notification-error = urgent; # originally cc2418
          misc = hialt1; # originally blue/base0D
        }
        else {}
      );

    enabledCustomApps = with spicePkgs.apps; [
      # BUG: new releases and lyrics plus both cause "something went wrong"
      # new-releases
      # lyrics-plus
      localFiles
      marketplace
    ];
    enabledExtensions = with spicePkgs.extensions; [
      # "playlistIcons" # only needed if not using dribbblish
      fullAlbumDate
      listPlaylistsWithSong
      playlistIntersection
      showQueueDuration
      featureShuffle
      playNext
      keyboardShortcut
      lastfm
      # genre
      historyShortcut
      hidePodcasts
      fullAppDisplay
      shuffle
    ];
  };
}
