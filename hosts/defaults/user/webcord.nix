{
  pkgs,
  config,
  ...
}: {
  home.file.".config/WebCord/Themes" = {
    # this will only be loaded by calling "webcord --add-css-theme=~/.config/WebCord/Themes"
    source = pkgs.callPackage config.system.theme.discordTheme {
      font = config.system.theme.font.display;
      inherit config;
    };
    recursive = true;
  };
}
