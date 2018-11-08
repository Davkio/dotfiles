bindkey -e
# -- Zsh prompt, display as just - with directory on rh/side
PROMPT="%{$reset_color%} - "
RPROMPT="%{$fg_no_bold[yellow]%}%1~ "

# -- History File
HISTFILE=~/.histfile
HISTSIZE=100
SAVEHIST=1000

# -- Color Directories
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS
#eval $( dircolors -b ~/.LS_COLORS )


# -------------------- #
# --   Completion   -- #
# -------------------- #

# -- TODO comment what all of these actually do 
# -- first one is most important, otherwise it fucks vim for some reason
# -- ???

zstyle -e ':completion:*' completer '
    if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]]; then
        _last_try="$HISTNO$BUFFER$CURSOR"
        reply=(_complete _ignored:complete _prefix _complete:full _correct _approximate)
    else
        rehash
        reply=(_complete _ignored:complete _prefix _complete:full _correct _approximate)
    fi' 
                                     
zstyle ':completion::prefix:*' completer _complete _ignored:complete
zstyle ':completion::complete:*:(all-|)files' ignored-patterns '*\~' tags
zstyle ':completion::complete:*' ignore-parents parent pwd
zstyle ':completion::complete:rm::(all-|)files' ignored-patterns
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion::full:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' '+r:|[._-/]=* r:|=* l:|[._-/]=* l:|=*'
zstyle -e ':completion:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*' menu select
zstyle ':completion:*' original true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:rm:*' ignore-line yes
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit -u

# -------------------- #
# -- ZSH setopt cases  #
# -------------------- #

setopt COMPLETEALIASES
setopt AUTO_CD
setopt NO_BEEP
setopt SHARE_HISTORY
setopt PUSHD_MINUS

# -- Globbing
setopt GLOB_COMPLETE
setopt EXTENDED_GLOB
setopt NO_CASE_GLOB
setopt NUMERIC_GLOB_SORT

# ------------ #
# -- Aliases - #
# ------------ #

# -- Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls -p --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=always -F --literal'
alias lsd='ls -d *(-/DN)'
alias lsl='ls -C1'
alias tree='tree -L 2'

# -- Utilities
alias xterm='xterm -fa Inconsolatazi4:size=12'
alias ping='ping -c 3'
alias gping='ping -c 1 www.google.com'
alias grep='grep --color=auto'
alias clearcache='sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"'
alias powersave='systemctl start thermald.service cpupower.service powertop.service laptop-mode.service'
alias screenleft='xrandr --output HDMI1 --mode 1920x1080 --left-of eDP1 --preferred --primary'
alias turboff='echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo'
alias fanoff='echo 0 | sudo tee /sys/kernel/debug/vgaswitcheroo/switch'

# -- Pacman
alias pacsyu='sudo pacman -Syu'
alias pacsa='sudo pacman -S "$@"'
alias pacss='pacman -Ss "$@"'
alias pacrns='sudo pacman -Rns "$@"'

# -- Developing
alias cdev='cd ~/dev/c/'
alias cppdev='cd ~/dev/cpp/'
alias hexo='~/dev/node/webblog/blog/node_modules/hexo/bin/hexo'

# -- Games
alias rewrite='wine ~/.wine/drive_c/Rewrite/Rewrite/SiglusEngine.exe&'
alias fsn='wine "~/[Fuwanovel] Fate stay night -English-/Fate.exe"&'


# -- Coloured Man
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;40;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# --- So i don't have to remember all the tar commands & shit
extract() {
  if [ -f $1 ] ; then
     case $1 in
       *.tar.bz2)        tar xvjpf $1    ;;
       *.tar.gz)         tar xzf $1      ;;
       *.bz2)            bunzip2 $1      ;;
       *.rar)            unrar e $1      ;;
       *.gz)             gunzip $1       ;;
       *.tar)            tar xf $1       ;;
       *.tbz2)           tar xjf $1      ;;
       *.tgz)            tar xzf $1      ;;
       *.zip)            unzip $1        ;;
       *.Z)              uncompress $1   ;;
       *.7z)             7z x $1         ;;
       *)                echo "'$1' is not an archive covered by this function"
       esac
       else
         echo "'$1' is not a valid file"
    fi
}

# -- Insert sudo with `
insert_sudo() { 
    BUFFER="sudo $BUFFER";
    CURSOR+=5;
}

zle -N insert_sudo insert_sudo
bindkey "^[\`" insert_sudo
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# -- Testing Area --- #
# ------------------- #

# -- this will stop any commands after this point affecting
# -- any system-level functionality as scripts don't have prompts

[ -z "$PS1" ] && return

function cd() {
    builtin cd "$@" && ls
}
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
