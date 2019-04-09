# ~/.bashrc: executed by bash(1) for non-login shells.
[[ $- == *i* ]] || return # return if not running interactively

# Utility functions for PATH setting.
path_append() {
  path_remove "$1"
  export PATH="${PATH}:$1";
}

path_prepend() {
  path_remove "$1"
  export PATH="$1:${PATH}";
}

path_remove() {
  export PATH="$(echo -n $PATH \
    | awk -v RS=: -v ORS=: '$0 != "'$1'"' \
    | sed 's/:$//')";
}

case "$(hostname)" in
  "apple"*)
    path_prepend "/opt/local/bin"
    path_prepend "/opt/local/sbin"
    path_prepend "/opt/local/libexec/gnubin"
    path_prepend "${HOME}/Documents/arts/build/src"
    ARTS_DATA_PATH="${HOME}/Documents/arts-xml-data"
    export ARTS_DATA_PATH="${HOME}/Documents/catalogue:${ARTS_DATA_PATH}"
    ;;
  "mlogin"*|"mistralpp"*)
    source /work/um0878/sw/profile/group.sh
    ulimit -Sv 32000000 # limit memory usage of single processes to 32GB
    export OMP_NUM_THREADS=8
    path_prepend "${HOME}/lkluft/dev/arts/build/src"
    . "${HOME}/lkluft/dev/arts/tools/bash_completion/completion_arts.sh"
    ARTS_DATA_PATH="/work/um0878/users/lkluft/dev/arts-xml-data"
    ARTS_DATA_PATH="/work/um0878/data/catalogue/hitran/hitran2012/:${ARTS_DATA_PATH}"
    export LC_ALL=C
    ;;
  vm-*.cen.uni-hamburg.de)
    module "purge"
    module "load git/2.16.2"
    ;;
  "thunder"*)
    export LC_ALL=C

    # Load group profile
    export APMETUSER="lkluft"
    . "/scratch/uni/u237/sw/profile.apmet/apmet.sh"

    # With great power comes great responsibility
    ulimit -Sv 32000000 # limit memory usage of single processes to 32GB
    export OMP_NUM_THREADS=8

    # ARTS environment
    path_prepend "${APMETSCRATCH}/users/lkluft/dev/arts/build/src"
    . "${HOME}/lkluft/dev/arts/tools/bash_completion/completion_arts.sh"
    ARTS_BUILD_PATH="${APMETSCRATCH}/users/lkluft/dev/arts/build/"
    ARTS_INCLUDE_PATH="${APMETSCRATCH}/users/lkluft/dev/arts/controlfiles"
    ARTS_DATA_PATH="${APMETSCRATCH}/users/lkluft/dev/arts-xml-data"
    ARTS_DATA_PATH="${APMETSCRATCH}/data/catalogue/hitran/:${ARTS_DATA_PATH}"
    export ARTS_{BUILD,INCLUDE,DATA}_PATH

    # Make Python work on head and batch nodes
    path_prepend "/scratch/uni/u237/sw/anaconda36/envs/python36/bin"  # fallback
    path_prepend "/dev/shm/u237002/anaconda36/envs/python36/bin"  # head only
    export PYTHONUSERBASE="/scratch/uni/u237/users/lkluft/.local"
    ;;
esac
path_prepend "${HOME}/bin"
path_prepend "${HOME}/.scripts"


# search PATH for cd command
export CDPATH=".:..:~"


# set TMPDIR to /tmp if unset
[[ -z "${TMPDIR}" ]] && export TMPDIR="/tmp"


# history settings
HISTCONTROL="ignoreboth" # ignore duplicates and lines with leading blank
HISTSIZE=10000
HISTFILESIZE=50000
HISTIGNORE="cd:u:x:h:c:ll:l:la:tm:t:sp:fb:wa"
PROMPT_COMMAND="history -a"


# prompt settings
export BLACK='\[\e[1;30m\]'
export WHITE='\[\e[1;37m\]'
export BLUE='\[\e[0;34m\]'
export CYAN='\[\e[0;36m\]'
export GREEN='\[\e[0;32m\]'
export PURPLE='\[\e[0;35m\]'
export RED='\[\e[0;31m\]'
export YELLOW='\[\e[0;33m\]'
export LIGHT_BLUE='\[\e[1;34m\]'
export LIGHT_CYAN='\[\e[1;36m\]'
export LIGHT_GREEN='\[\e[1;32m\]'
export LIGHT_PURPLE='\[\e[1;35m\]'
export LIGHT_RED='\[\e[1;31m\]'
export LIGHT_YELLOW='\[\e[1;33m\]'
export DEFAULT='\[\e[0m\]'

case "$(hostname)" in
  "acer") PSCOLOR="$LIGHT_CYAN" ;;
  "apple"*) PSCOLOR="$LIGHT_RED" ;;
  "medion") PSCOLOR="$LIGHT_PURPLE" ;;
  "mistralpp"*) PSCOLOR="$LIGHT_GREEN" ;;
  "mlogin"*) PSCOLOR="$LIGHT_GREEN" ;;
  "squall"*) PSCOLOR="$LIGHT_YELLOW" ;;
  "thunder"*) PSCOLOR="$LIGHT_BLUE" ;;
  *) PSCOLOR="$WHITE" ;;
esac

PS1="$PSCOLOR\W$DEFAULT "
PS2="$PSCOLOR>$DEFAULT "

if [[ "$(hostname)" == "mlogin"* || "$(hostname)" == "mistralpp"* ]]; then
  PS1="$PSCOLOR\u@\h:\W$DEFAULT "
  PS2="$PSCOLOR>$DEFAULT "
fi

# editor
export EDITOR="vim"

# pager settings
export PAGER="less"
export LESS="-reFsX"

# if existing use hosts-system for ssh host completion
[[ -r '/etc/hosts-system' ]] && export HOSTFILE='/etc/hosts-system'


# When running without X11 server, use 'Agg' backend for matplotlib.
[[ -z "$DISPLAY" ]] && export MPLBACKEND="Agg"

# use anaconda python environment if available
[[ -d "${HOME}/.anaconda/bin" ]] && path_prepend "${HOME}/.anaconda/bin"


# language settings
export LANG="en_US.utf-8"


# shell options
shopt -s cdspell checkwinsize cmdhist globstar histappend

# use physical directory structure instead of symlinks (-P)
# return value of a pipe is zero or the last non-zero status (pipefail)
set -Po pipefail


# make less more friendly for non-text input files, see lesspipe(1)
[[ -x "/usr/bin/lesspipe" ]] && eval "$(lesspipe)"


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [[ -f "/opt/local/etc/profile.d/bash_completion.sh" ]]; then
    . "/opt/local/etc/profile.d/bash_completion.sh"
  elif [[ -f "/usr/share/bash-completion/bash_completion" ]]; then
    . "/usr/share/bash-completion/bash_completion"
  elif [[ -f "/etc/bash_completion" ]]; then
    . "/etc/bash_completion"
  fi
fi

# set completion for own scripts and functions
complete -o plusdirs -f -X '!*.tex' latexmk
complete -o plusdirs -f -X '!*.@(pdf|png|jpg)' o
complete -o plusdirs -f -X '!*.tex' t

# enable color support of ls
hash dircolors &> /dev/null \
  && [[ -r "${HOME}/.dircolors" ]] \
  && eval "$(dircolors -b ~/.dircolors)" \
  || eval "$(dircolors -b)"


# alias definitions. edit in ~/.bash_aliases
[[ -f "${HOME}/.bash_aliases" ]] && . "${HOME}/.bash_aliases"


# bash functions. edit in ~/.bash_functions
[[ -f "${HOME}/.bash_functions" ]] && . "${HOME}/.bash_functions"
