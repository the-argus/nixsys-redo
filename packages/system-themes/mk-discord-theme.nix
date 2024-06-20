{stdenvNoCC, ...}: {
  config,
  font,
  ...
}:
with config.banner.palette; let
  # light mode literally not supported lol
  css = builtins.toFile "system.theme.css" ''
    .theme-dark {
        --background-primary: #${base02};
        --background-secondary: #${base01};
        --background-secondary-alt: #${base02};
        --channeltextarea-background: #${base03};
        --background-tertiary: #${base00};
        --background-accent: #${highlight};
        --text-normal: #${base05};
        --text-spotify: #1DB954;
        --text-muted: #${base03};
        --text-link: #${link};
        --background-floating: #${base01};
        --header-primary: #${base05};
        --header-secondary: #${base0B};
        --header-spotify: #${base0B};
        --interactive-normal: #${base05};
        --interactive-hover: #${highlight};
        --interactive-active: #${base05};
        --ping: #${highlight};
        --background-modifier-selected: #${base02}b4;
        --scrollbar-thin-thumb: #${base00};
        --scrollbar-thin-track: transparent;
        --scrollbar-auto-thumb: #${base00};
        --scrollbar-auto-track: transparent;
    }

    .theme-light {
        --background-primary: #faf4ed;
        --background-secondary: #fffaf3;
        --background-secondary-alt: #f2e9de;
        --channeltextarea-background: #f2e9de;
        --background-tertiary: #f2e9de;
        --background-accent: #d7827e;
        --text-normal: #575279;
        --text-spotify: #575279;
        --text-muted: #6e6a86;
        --text-link: #286983;
        --background-floating: #f2e9de;
        --header-primary: #575279;
        --header-secondary: #575279;
        --header-spotify: #56949f;
        --interactive-normal: #575279;
        --interactive-hover: #6e6a86;
        --interactive-active: #575279;
    }

    body {
        --font-display: ${font.name};
    }

    .body-2wLx-E, .headerTop-3GPUSF, .bodyInnerWrapper-2bQs1k, .footer-3naVBw {
        background-color: var(--background-tertiary);
    }

    .title-17SveM, .name-3Uvkvr{
        font-size: ${builtins.toString font.size}px;
    }

    .panels-3wFtMD {
        background-color: var(--background-secondary);
        padding-left: 5px;
        padding-right: 5px;
    }

    .username-h_Y3Us {
        font-family: var(--font-display);
        font-size: ${builtins.toString font.size}px;
    }

    .peopleColumn-1wMU14, .panels-j1Uci_, .peopleColumn-29fq28, .peopleList-2VBrVI, .content-2hZxGK, .header-1zd7se, .root-g14mjS .small-23Atuv .fullscreenOnMobile-ixj0e3{
        background-color: var(--background-secondary);
    }

    .textArea-12jD-V, .lookBlank-3eh9lL,  .threadSidebar-1o3BTy, .scrollableContainer-2NUZem, .perksModalContentWrapper-3RHugb, .theme-dark .footer-31IekZ, .theme-light .footer-31IekZ{
        background-color: var(--background-tertiary);
    }

    .numberBadge-2s8kKX, .base-PmTxvP, .baseShapeRound-1Mm1YW, .bar-30k2ka, .unreadMentionsBar-1Bu1dC, .mention-1f5kbO, .active-1SSsBb, .disableButton-220a9y {
        background-color: var(--ping) !important;
    }

    .lookOutlined-3sRXeN.colorRed-1TFJan, .lookOutlined-3sRXeN.colorRed-1TFJan {
        color: var(--ping) !important;
    }

    .header-3OsQeK, .container-ZMc96U {
        box-shadow: none!important;
        border: none!important;
    }

    .content-1gYQeQ, .layout-1qmrhw, .inputDefault-3FGxgL, .input-2g-os5, .input-2z42oC, .role-2TIOKu, .searchBar-jGtisZ {
        border-radius: 6px;
    }

    .layout-1qmrhw:hover, .content-1gYQeQ:hover {
        background-color: var(--background-modifier-selected)!important;
    }
  '';
in (stdenvNoCC.mkDerivation {
  name = "discord-theme-in-color";
  dontBuild = true;
  installPhase = ''
    mkdir $out
    cp ${css} $out/system.theme.css
  '';
  dontUnpack = true;
})
