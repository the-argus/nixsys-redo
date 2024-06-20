{pkgs, ...}: let
  iconsfile = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/gokcehan/lf/b47cf6d5a525c39db268c2f7b77e2b7497843b17/etc/icons.example";
    sha256 = "04jnldz0y2fj4ymypzmvs7jjbvvjrwzdp99qp9r12syfk65nh9cn";
  };

  cleaner = pkgs.writeShellScript "lf-cleaner.sh" ''
    kitty +icat --clear --silent --transfer-mode file
  '';

  previewer = pkgs.writeShellScript "lf-previewer.sh" ''
    case "$1" in
      *.tar*) tar tf "$1";;
      *.zip) unzip -l "$1";;
      *.rar) unrar l "$1";;
      *.7z) 7z l "$1";;
      *.pdf) ${pkgs.poppler_utils}/bin/pdftotext "$1" -;;
      *.md) ${pkgs.glow}/bin/glow "$1";;
      *) ${pkgs.highlight}/bin/highlight -O ansi "$1";;
    esac
  '';

  sandbox = pkgs.writeShellScript "lf-sandbox.sh" ''
    # kitty previews
    if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$1")" =~ ^image ]]; then
      file=$1
      w=$2
      h=$3
      x=$4
      y=$5
      kitty +icat --silent --transfer-mode file --place "${"\${w}x\${h}@\${x}x\${y}"}" "$file"
      exit 1
    fi
    set -euo pipefail
    (
      exec ${pkgs.bubblewrap}/bin/bwrap \
       --proc /proc \
       --dev /dev  \
       --ro-bind / / \
       --unshare-all \
       --new-session \
       ${pkgs.runtimeShell} ${previewer} "$@"
    )
  '';
in {
  home.file.".config/lf/icons".source = iconsfile;
  programs.lf = {
    enable = true;
    settings = {
      drawbox = true;
      dirfirst = true;
      icons = true;
      ignorecase = true;
      preview = true;
      shell = "${pkgs.dash}/bin/dash";
      shellopts = "-eu";
      tabstop = 2;
      info = "size";
    };
    previewer = {
      source = sandbox;
      keybinding = "i";
    };
    extraConfig = ''
      set cleaner ${cleaner}

      set ifs "\n"

      ${"\${{"}
        w=$(tput cols)
        if [ $w -le 160 ]; then
          lf -remote "send $id set ratios 1:2"
        else
          lf -remote "send $id set ratios 1:2:3"
        fi
      }}

      %[ $LF_LEVEL -eq 1 ] || echo "Warning: You're in a nested lf instance!"
    '';

    commands = {
      open = "$set -f; ${pkgs.myPackages.rifle}/bin/rifle -p 0 $fx";
      z = ''
        %{{
          # result="$(zoxide query --exclude $PWD $@)"
          result="$(zoxide query $@)"
          lf -remote "send $id cd $result"
        }}
      '';

      zi = ''
        ${"\${{"}
          result="$(zoxide query $@ -i)"
          lf -remote "send $id cd $result"
        }}
      '';

      fzf_jump = ''
        ${"\${{"}
          res="$(find . -maxdepth 1 | fzf --reverse --header='Jump to location' | sed 's/\\/\\\\/g;s/"/\\"/g')"
          if [ -d "$res" ] ; then
            cmd="cd"
          elif [ -f "$res" ] ; then
            cmd="select"
          else
            exit 0
          fi
          lf -remote "send $id $cmd \"$res\""
        }}
      '';

      fzf_search = ''
        ${"\${{"}
        res="$( \
          RG_PREFIX="rg --column --line-number --no-heading --color=always \
            --smart-case "
          FZF_DEFAULT_COMMAND="$RG_PREFIX ${"''"}" \
            fzf --bind "change:reload:$RG_PREFIX {q} || true" \
            --ansi --layout=reverse --header 'Search in files' \
            | cut -d':' -f1
          )"
          [ ! -z "$res" ] && lf -remote "send $id select \"$res\""
        }}
      '';

      # mkdir command which joins spaces into one name
      mkdir = "%IFS=\" \"; mkdir -p -- \"$*\"";

      bulkrename = ''
        ${"\${{"}
          ${pkgs.vimv-rs}/bin/vimv -- $(basename -a -- $fx)

          lf -remote "send $id load"
          lf -remote "send $id unselect"
        }}
      '';
    };

    keybindings = {
      "<c-f>" = ":fzf_jump";
      "<c-r>" = ":fzf_search";
      a = "push :mkdir<space>";
      "<c-z>" = "$ kill -STOP $PPID";
      "<enter>" = ":open";
    };
  };
}
