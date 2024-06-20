{
  pkgs,
  username,
  settings,
  config,
  lib,
  ...
}: let
  plugins = {
    zsh-window-title = let
      # using full plugin adds 15ms to startup time
      # but makes the window title include currently running commands
      useFullPlugin = false;
    in rec {
      name = "olets/zsh-window-title";
      source = pkgs.fetchgit {
        url = "https://github.com/olets/zsh-window-title";
        rev = "0253f338b3ef74f3e3c2e833b906c602c94552a7";
        sha256 = "0zdcrz0y7aw4f7c1i6b82pg2m24z5hfz7hmi4xlhqrpvz305bhas";
      };
      init =
        if useFullPlugin
        then ''
          source ${source}/zsh-window-title.zsh
        ''
        else ''
          __zsh-window-title:precmd() {
              ZSH_WINDOW_TITLE_DIRECTORY_DEPTH=8
          	local title=$(print -P "%$ZSH_WINDOW_TITLE_DIRECTORY_DEPTH~")
              if [ "${title:0:1}" = '~' ]; then
                title=$(echo $title | sed '0,/~/{s/~/$HOME/}')
              fi
          	'builtin' 'echo' -ne "\033]0;$title\007"
          }
          add-zsh-hook precmd __zsh-window-title:precmd
        '';
    };

    zsh-autocomplete = rec {
      name = "marlonrichert/zsh-autocomplete";
      source = pkgs.fetchgit {
        url = "https://github.com/marlonrichert/zsh-autocomplete";
        rev = "aed8e17de6d16dca940a344117894f3e57022ed5";
        sha256 = "0p02iqnxc93ifmyr5m9zxkbbl5xhydqyki5m11h6kw9i94gy9m15";
      };
      init = ''
        source ${source}/zsh-autocomplete.plugin.zsh
        #THERE SHOULD BE NO CALLS TO COMPINIT IF THIS IS USED
      '';
    };

    zsh-completions = rec {
      name = "zsh-users/zsh-completions";
      source = pkgs.fetchgit {
        url = "https://github.com/zsh-users/zsh-completions";
        rev = "879f4b6515d3e7808e8d97d65c679ed8d044f57a";
        sha256 = "11bsbx9jx1n9hqb2lmw3dmv0s585sh5sppz476w71qkq8xmar3c0";
      };
      init = ''
        fpath+=(${source}/src)
      '';
    };

    zsh-autopair = rec {
      name = "hlissner/zsh-autopair";
      source = pkgs.fetchgit {
        url = "https://github.com/hlissner/zsh-autopair";
        rev = "396c38a7468458ba29011f2ad4112e4fd35f78e6";
        sha256 = "0q9wg8jlhlz2xn08rdml6fljglqd1a2gbdp063c8b8ay24zz2w9x";
      };
      init = ''
        source ${source}/autopair.zsh
        autopair-init
      '';
    };

    sandboxd = rec {
      name = "benvan/sandboxd";
      source = pkgs.fetchgit {
        url = "https://github.com/benvan/sandboxd";
        rev = "91e0b6ae7bf960271bc69261f3582f144acdf234";
        sha256 = "04jsx86h32jm8h6c5y4b0az8r47shnv7iyjg1fpqvw1xxvrdwf58";
      };
      init = "source ${source}/sandboxd.plugin.zsh";
    };

    zsh-nix-shell = rec {
      name = "zsh-nix-shell";
      file = "nix-shell.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "chisui";
        repo = "zsh-nix-shell";
        rev = "v0.5.0";
        sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
      };
      init = ''
        source ${src}/nix-shell.plugin.zsh
      '';
    };
  };
in {
  home.file.".config/sandboxd/sandboxrc".text = ''
    sandbox_init_completion() {
      autoload -U compinit && compinit
    }

    sandbox_hook completion cd
    sandbox_hook completion git
    sandbox_hook completion systemctl
    sandbox_hook completion kill
    sandbox_hook completion killall
    sandbox_hook completion pkill
  '';

  programs.zsh = let
    dDir = ".config/zsh";
  in {
    enable = true;
    autocd = true;
    dotDir = dDir;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    history = {
      path = "$HOME/${dDir}/histfile";
      ignorePatterns = ["ls *" "exit" "clear" "fg"];
      ignoreDups = true;
      share = false;
    };

    # in order to get instant prompt working for p10k, this needs to run first
    # includes fixes for direnv
    initExtraFirst = ''
      (( ${"$\{+commands[direnv]}"} )) && emulate zsh -c "$(direnv export zsh)"

      if [[ -r "${"$\{XDG_CACHE_HOME:-$HOME/.cache}"}/p10k-instant-prompt-${"$\{(%):-%n}"}.zsh" ]]; then
        source "${"$\{XDG_CACHE_HOME:-$HOME/.cache}"}/p10k-instant-prompt-${"$\{(%):-%n}"}.zsh"
      fi

      (( ${"$\{+commands[direnv]}"} )) && emulate zsh -c "$(direnv hook zsh)"
    '';

    shellAliases = let
      mkStartXAlias = wmName: (lib.optionalAttrs config.desktops.${wmName}.enable {"${wmName}-start" = "startx $HOME/.xinitrc ${wmName}";});
    in
      {
        # regular aliases
        nf = "neofetch";
        search = "nix search nixpkgs";
        matrix = "tmatrix -c default -C yellow -s 60 -f 0.2,0.3 -g 10,20 -l 1,50 -t \"hello, ${username}.\"";
        umatrix = "unimatrix -a -c yellow -f -s 95 -l aAcCgGkknnrR";
        batt = "cat /sys/class/power_supply/BAT0/capacity";

        # unused mostly
        ix = "curl -F 'f:1=<-' ix.io";
        rm = "rm -i";
        nocolor = ''sed "s/\x1B\[[0-9;]\{1,\}[A-Za-z]//g"'';
      }
      # aliases like i3gaps-start to start a particular wm via startx
      // (lib.optionalAttrs config.desktops.xorg.enable (mkStartXAlias "i3gaps") // (mkStartXAlias "qtile") // (mkStartXAlias "ratpoison") // (mkStartXAlias "awesome"))
      # allow typing "gnome" from tty to start wayland gnome session
      // (lib.optionalAttrs config.desktops.gnome.enable {
        gnome = "dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY && XDG_SESSION_TYPE=wayland dbus-run-session -- gnome-shell --display-server --wayland";
      });

    initExtra = with plugins; ''
      # PLUGINS----------------------------------------------------------------
      ${sandboxd.init}
      ${zsh-completions.init}
      ${zsh-nix-shell.init}
      ${zsh-autopair.init}
      ${zsh-window-title.init}
      # INCLUDES---------------------------------------------------------------

      # hole in reproducability bc i like to add aliases quickly
      [ -f  "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

      function open () {
      	xdg-open "$@">/dev/null 2>&1
      }

      function ls () {
        command ls --color=auto --group-directories-first $@
      }
      function lsl () {
      	command ls -la --color=auto --group-directories-first $@ | command grep "^d" && ls -la $1 | command grep -v "^d"
      }

      function where () {
        readlink $(whereis $1 | cut --delimiter " " --fields 2)
      }
      function lsd () {
        lsd --color=auto --group-dirs=first $@
      }
      function lsdl () {
        lsd -la $@
      }

      // these are only necessary if we dont have rg or delta installed, really
      // function diff () { command diff --color=auto "$@"; }
      // function grep () { command grep "$@" --color=always; }

      function ip () { command ip -color=auto "$@"; }

      lfcd () {
        tmp="$(mktemp)"
        lf -last-dir-path="$tmp" "$@"
        if [ -f "$tmp" ]; then
          dir="$(cat "$tmp")"
          rm -f "$tmp"
          if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
              cd "$dir"
            fi
          fi
        fi
      }
      # bind ctrl-o to lfcd
      bindkey -s '^o' 'lfcd\n'

      # makes files with special characters compatible with fat and exfat
      function filecompat () {
          if [[ "$1" == "" ]]; then
            echo "provide a directory to make files compatible in."
          fi
          local total=0
          for file in "$1"/*; do
            if [[ -d $file ]]; then
              continue
            fi
            # new_filename=$(echo $file | tr -dc '[:alnum:]\n\r')
            new_filename=${"$\{file//[^[:alnum:]]/}"}
            if [[ $file == $new_filename ]]; then
              continue
            fi
            mv -- "$file" "$new_filename"
            total=$((total + 1))
          done

          echo "renamed $total files."
      }

      function lock () {
          sleep 0.2

          ${pkgs.i3lock-fancy}/bin/i3lock-fancy -f "Fira-Code-Regular-Nerd-Font-Complete" -t "hello, argus."

          pactl set-sink-mute @DEFAULT_SINK@ on
          ~/.local/bin/volume.sh refresh
      }

      eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
    '';
  };
}
