{
  pkgs,
  top-level-color-schemes,
  # packages that wont appear in pkgs until the overlay is completed, so we
  # have to pass them explicitly
  top-level-material-black-frost-gtk-theme,
  top-level-nordarc-nordzy-icon-theme,
  top-level-posys-improved-cursor-theme,
  top-level-google-dot-black-cursor-theme,
  top-level-breezex-black-cursor-theme,
  ...
}: let
  override = pkgs.lib.attrsets.recursiveUpdate;

  discordThemes = pkgs.callPackage ./discord-themes.nix {};

  mkDiscordThemeFromSystemTheme = pkgs.callPackage ./mk-discord-theme.nix {};

  schemes = top-level-color-schemes;

  # gtk theme packages
  material-black-frost-gtk-theme = top-level-material-black-frost-gtk-theme;
  nordarc-nordzy-icon-theme = top-level-nordarc-nordzy-icon-theme;
  posys-improved-cursor-theme = top-level-posys-improved-cursor-theme;
  google-dot-black-cursor-theme = top-level-google-dot-black-cursor-theme;
  breezex-black-cursor-theme = top-level-breezex-black-cursor-theme;

  # theme and icon selections from packages given variant names
  rosePineTheme = {
    name = "rose-pine";
    package = pkgs.rose-pine-gtk-theme;
  };

  rosePineIcons = {
    name = "rose-pine";
    package = pkgs.rose-pine-icon-theme;
  };

  kanagawaTheme = {
    package = pkgs.kanagawa-gtk-theme;
    name = "Kanagawa-B"; # or Kanagawa-BL
  };

  kanagawaIcons = {
    package = pkgs.kanagawa-icon-theme;
    name = "Kanagawa";
  };

  materialBlackFrostTheme = {
    package = material-black-frost-gtk-theme;
    name = "Material-Black-Frost";
  };

  materialBlackFrostIcons = {
    package = material-black-frost-gtk-theme;
    name = "Black-Frost-Numix-FLAT"; # also Black-Frost-Numix and Black-Frost-Suru
  };

  paperIcons = {
    package = pkgs.paper-icon-theme;
    name = "Paper-Mono-Dark";
  };

  numixCircleIcons = {
    package = pkgs.numix-icon-theme-circle;
    name = "Numix-Circle"; # or Numix-Circle-Light
  };

  marwaitaTheme = {
    package = pkgs.marwaita;
    name = "Marwaita"; # also Marwaita Alt, Color, Color Dark, Dark
  };

  nordicTheme = {
    package = pkgs.nordic;
    name = "Nordic";
  };

  nordarcNordzyIcons = {
    package = nordarc-nordzy-icon-theme;
    name = "NordArc";
  };

  posysImproved = {
    name = "Posy_Cursor"; # can also append _Black _Mono _Mono_Black and _Strokeless
    package = posys-improved-cursor-theme;
    size = 16;
  };

  nordzyCursor = {
    name = "Nordzy-Cursors";
    package = nordarc-nordzy-icon-theme;
    size = 16;
  };

  googleDotBlack = rec {
    name = "GoogleDotBlack";
    package = google-dot-black-cursor-theme;
    size = 16;
  };
in rec {
  defaultTheme = rec {
    wallpaper = "rose/delorean.png";
    gtk = {
      theme = "gtkNix";
      iconTheme = rosePineIcons;
      cursorTheme = posysImproved;
    };
    font = rec {
      monospace = {
        name = "FiraCode Nerd Font";
        size = 12;
        package = pkgs.nerdfonts.override {fonts = ["FiraCode "];};
      };
      display = {
        name = "Fira Code";
        size = 11;
        package = pkgs.fira-code;
      };
    };
    discordTheme = mkDiscordThemeFromSystemTheme;
    scheme = schemes.rosepine;
    opacity = "1.0";
  };

  rosepine = defaultTheme;

  rosepineWithoutGtkNix = override defaultTheme {
    discordTheme = discordThemes.rosepine;
    gtk.theme = rosePineTheme;
  };

  macchiato = override defaultTheme {
    wallpaper = "colourful-place.jpg";
    scheme = schemes.macchiato;
    font = override defaultTheme.font {
      monospace = {
        name = "Martian Mono";
        size = 12;
        package = pkgs.martian-mono;
      };
    };
  };

  amber-forest = override defaultTheme rec {
    wallpaper = "paradise.jpg";
    scheme = schemes.amber-forest;
  };

  gruvboxWithGtkNix = override defaultTheme rec {
    wallpaper = "gruv/pawel-czerwinski-gruvpaint.jpg";
    scheme = schemes.gruv;
    gtk = {
      theme = "gtkNix";
      iconTheme = {
        package = pkgs.gruvbox-dark-icons-gtk;
        name = "oomox-gruvbox-dark";
      };
      cursorTheme = googleDotBlack;
    };
  };

  gruvbox = override defaultTheme rec {
    wallpaper = "gruv/fossil-gruv.png";
    scheme = schemes.gruv;
    gtk = {
      theme = {
        package = pkgs.gruvbox-gtk-theme;
        name = "Gruvbox-Dark-B";
      };
      iconTheme = {
        package = pkgs.gruvbox-dark-icons-gtk;
        name = "oomox-gruvbox-dark";
      };
      cursorTheme = posysImproved;
    };
    opacity = "0.9";
  };

  nordic = override defaultTheme {
    wallpaper = "nord/lake.png";
    gtk = {
      theme = nordicTheme;
      iconTheme = nordarcNordzyIcons;
      cursorTheme = nordzyCursor;
    };
    discordTheme = discordThemes.nordic;
    scheme = schemes.nord;
    opacity = "0.8";
  };

  nordicWithGtkNix = override nordic {
    wallpaper = "nord/canyon.png";
    gtk.theme = "gtkNix";
  };

  orchis = override defaultTheme {
    wallpaper = "green-sky.png";
    gtk = {
      theme = {
        name = "Orchis-Light"; # Orchis, Orchis-Light, Orchis-Compact, Orchis-Dark, Orchis-Dark-Compact, Orchis-Green, Orchis-Green Compact, etc
        # colors: Green Grey Orange Pink Purple Red Yellow
        package = pkgs.orchis;
      };
      iconTheme = {
        name = "Tela-circle"; # or Tela-circle-dark
        package = pkgs.tela-circle-icon-theme;
      };
    };
  };

  drifter = override defaultTheme rec {
    wallpaper = "hld-wallpaper.png";
    font = defaultTheme.font;
    scheme = schemes.drifter;
    gtk = {
      theme = "gtkNix";
      iconTheme = {
        name = "Tela-circle";
        package = pkgs.tela-circle-icon-theme;
      };
    };
    opacity = "0.9";
  };
}
