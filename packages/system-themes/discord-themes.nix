{
  stdenvNoCC,
  fetchgit,
  ...
}: let
  mkTheme = fetchArgs: (stdenvNoCC.mkDerivation {
    name = builtins.baseNameOf fetchArgs.url;
    src = fetchgit fetchArgs;
    installPhase = ''
      mkdir $out
      mv *.theme.css THEME.theme.css
      mv * $out
    '';
  });
in {
  fluent = mkTheme {
    url = "https://github.com/DiscordStyles/Fluent";
    rev = "7a7b62e89648d845c7b388aab0a77febb628ea4b";
    sha256 = "0lz8h48wf1ja31yb9sb8n7a2gfwncqldf8dar7d0k8wcl09z782y";
  };

  softx = mkTheme {
    url = "https://github.com/DiscordStyles/SoftX";
    rev = "ef11558a47b3ce6b590e8d8ea47e34fc1de32d9c";
    sha256 = "1b8k640jymd6hcqr9930i6m98ihxcya18biaazsp5hcvkxh25ac6";
  };

  rosepine = mkTheme {
    url = "https://github.com/rose-pine/discord";
    rev = "fafe99d677079a07d00e37e9b455641c194444e1";
    sha256 = "0wl0f1jgqmfgfxmgahkwhpx4ngnm57gsyv663p2mn552768iihl3";
  };

  slate = mkTheme {
    url = "https://github.com/DiscordStyles/Slate";
    rev = "9eda73ab6a05be53fcf4879c3ca7543bd6d02c9e";
    sha256 = "06sdlvk8v90x9x5m8qxpmxxhq6g9cbn8yw7acwi0j08h9qrsg0a0";
  };

  lavender = mkTheme {
    url = "https://github.com/Lavender-Discord/Lavender";
    rev = "a3a3b3692f13a2e4f717960476ffe6e30a1febae";
    sha256 = "08zyzd57d6h5rlg1mxscxfd055vg8pyd490rg90wp303a6a0igm3";
  };

  darkmatter = mkTheme {
    url = "https://github.com/DiscordStyles/DarkMatter";
    rev = "50a19c54b417357aadd885e38fc222db0b8f6520";
    sha256 = "0wjwxdhjdixmzgayb0r70hj65w8jsd47ifha9hxrrkzk6ws3fl58";
  };

  nordic = mkTheme {
    url = "https://github.com/orblazer/discord-nordic";
    rev = "9808387ffcd2824e5b9a440f7e5e15ba2c8b7d00";
    sha256 = "0ahrwxkla9gqjlgff337jcna20v5ncxlkcyssli89k75axvypzr1";
  };
}
