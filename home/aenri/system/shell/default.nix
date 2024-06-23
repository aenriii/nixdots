{pkgs, ...}: let
  themepkg = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "zsh-syntax-highlighting";
    rev = "06d519c20798f0ebe275fc3a8101841faaeee8ea";
    sha256 = "sha256-Q7KmwUd9fblprL55W0Sf4g7lRcemnhjh4/v+TacJSfo=";
  };
in {
  home = {
    shellAliases = {
      c = "nvim";
      cp = "cp -i";
      f = "neofetch --sixel";
      p = "pfetch";
      fetch = "neofetch w3m";
      grep = "grep --color=auto";
      mv = "mv -i";
      rip = "rip -i";
      g = "git";
      ga = "git add";
      gaa = "git add .";
      gb = "git branch";
      gc = "git commit";
      gcm = "git commit --message";
      gco = "git checkout";
      gd = "git diff";
      gi = "git init";
      gp = "git pull";
      gs = "git status";
    };
    sessionVariables = {
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
      DIRENV_LOG_FORMAT = ""; # Blank so direnv will shut up
    };
  };

  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        bindkey -s ^f "tmux-sessionizer-script\n"
        # Export PATHs for applications
        export PATH=$PATH:~/.local/bin/
        export PATH=/tmp/lazy-lvim/bin:$PATH
        export PATH="$PATH:/home/aenri/.emacs.d/bin"
        export PATH="$PATH:/home/aenri/.config/emacs/bin"
        export PATH="$PATH:/run/current-system/sw/bin/jdtls"
        export PATH="$PATH:/run/current-system/sw/bin/jdt-language-server"
        export PATH="$PATH:/etc/profiles/per-user/aenri/bin/flutter"
        export PATH="$PATH:/home/aenri/Android/Sdk"
        export PATH="$PATH:/home/aenri/Android/Sdk/platform-tools/"
        export PATH="$PATH:/home/aenri/Android/Sdk/cmdline-tools/latest/bin"
        export PATH="$PATH:$FORGIT_INSTALL_DIR/bin"
        export WINIT_UNIX_BACKEND=x11 neovide

        # Autosuggest
        ZSH_AUTOSUGGEST_USE_ASYNC="true"

        while read -r option
        do
        setopt $option
        done <<-EOF
        AUTO_CD
        AUTO_LIST
        AUTO_MENU
        AUTO_PARAM_SLASH
        AUTO_PUSHD
        APPEND_HISTORY
        ALWAYS_TO_END
        COMPLETE_IN_WORD
        CORRECT
        EXTENDED_HISTORY
        HIST_EXPIRE_DUPS_FIRST
        HIST_FCNTL_LOCK
        HIST_IGNORE_ALL_DUPS
        HIST_IGNORE_DUPS
        HIST_IGNORE_SPACE
        HIST_REDUCE_BLANKS
        HIST_SAVE_NO_DUPS
        HIST_VERIFY
        INC_APPEND_HISTORY
        INTERACTIVE_COMMENTS
        MENU_COMPLETE
        NO_NOMATCH
        PUSHD_IGNORE_DUPS
        PUSHD_TO_HOME
        PUSHD_SILENT
        SHARE_HISTORY
        EOF

        while read -r option
        do
        unsetopt $option
        done <<-EOF
        CORRECT_ALL
        HIST_BEEP
        MENU_COMPLETE
        EOF

        # Group matches and describe.
        zstyle ':completion:*' sort false
        zstyle ':completion:complete:*:options' sort false
        zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
        zstyle ':completion:*' special-dirs true
        zstyle ':completion:*' rehash true

        zstyle ':completion:*' menu yes select # search
        zstyle ':completion:*' list-grouped false
        zstyle ':completion:*' list-separator '''
         zstyle ':completion:*' group-name '''
         zstyle ':completion:*' verbose yes
         zstyle ':completion:*:matches' group 'yes'
         zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
         zstyle ':completion:*:messages' format '%d'
         zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
         zstyle ':completion:*:descriptions' format '[%d]'

         # Fuzzy match mistyped completions.
         zstyle ':completion:*' completer _complete _match _approximate
         zstyle ':completion:*:match:*' original only
         zstyle ':completion:*:approximate:*' max-errors 1 numeric

         # Don't complete unavailable commands.
         zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

         # Array completion element sorting.
         zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

         # fzf-tab
         zstyle ':fzf-tab:complete:_zlua:*' query-string input
         zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
         zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
         zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
         zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
         zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
         zstyle ':fzf-tab:*' switch-group ',' '.'
         zstyle ":completion:*:git-checkout:*" sort false
         zstyle ':completion:*' file-sort modification
         zstyle ':completion:*:exa' sort false
         zstyle ':completion:files' sort false
      '';

      shellAliases = {
        sudo = "doas";
        c = "nvim";
        cp = "cp -i";
        f = "neofetch --sixel";
        p = "pfetch";
        fetch = "neofetch w3m";
        grep = "grep --color=auto";
        mv = "mv -i";
        rip = "rip -i";
        postman = "postman --use-gl=desktop";
        insomnia = "insomnia --use-gl=desktop";
        beekeeper-studio = "beekeeper-studio --use-gl=desktop";
        g = "git";
        ga = "git add";
        gaa = "git add .";
        gb = "git branch";
        gc = "git commit";
        gcm = "git commit --message";
        gco = "git checkout";
        gd = "git diff";
        gi = "git init";
        gp = "git pull";
        gs = "git status";
      };

      oh-my-zsh = {
        enable = true;
        theme = "bira";
        plugins = [
          "git"
          "colorize"
          "colored-man-pages"
          "command-not-found"
          "history-substring-search"
        ];
      };

      plugins = with pkgs; [
        {
          name = "forgit"; # i forgit :skull:
          file = "forgit.plugin.zsh";
          src = fetchFromGitHub {
            owner = "wfxr";
            repo = "forgit";
            rev = "99cda3248c205ba3c4638c4e461afce01a2f8acb";
            sha256 = "0jd0nl0nf7a5l5p36xnvcsj7bqgk0al2h7rdzr0m1ldbd47mxdfa";
          };
        }
        {
          name = "zsh-autopair";
          file = "zsh-autopair.plugin.zsh";
          src = fetchFromGitHub {
            owner = "hlissner";
            repo = "zsh-autopair";
            rev = "396c38a7468458ba29011f2ad4112e4fd35f78e6";
            sha256 = "0q9wg8jlhlz2xn08rdml6fljglqd1a2gbdp063c8b8ay24zz2w9x";
          };
        }
        {
          name = "fzf-tab";
          file = "fzf-tab.plugin.zsh";
          src = fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "5a81e13792a1eed4a03d2083771ee6e5b616b9ab";
            sha256 = "0lfl4r44ci0wflfzlzzxncrb3frnwzghll8p365ypfl0n04bkxvl";
          };
        }
        {
          name = "ctp-zsh-syntax-highlighting";
          src = themepkg;
          file = themepkg + "/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh";
        }
      ];
    };
  };
}
