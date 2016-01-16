# ~/.bashrc: executed by bash(1) for non-login shells.
[[ $- == *i* ]] || return # return if not running interactively


# path settings
[[ "$(uname -s)" == "SunOS" ]] && export PATH="/opt/csw/gnu:${PATH}"

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
    path_prepend "/opt/local/libexec/gnubin"
    ;;
  "squall"*)
    module "purge"
    module "load grads cdo git python/2.7-ve3"
    ;;
  "thunder"*)
    . "/scratch/uni/u237/sw/profile.apmet/apmet.sh"
    path_prepend "${HOME}/lkluft/arts/build/src"
    . "${HOME}/lkluft/arts/tools/bash_completion/completion_arts.sh"
    export ARTS_DATA_PATH="${APMETSCRATCH}/users/lkluft/arts-xml-data"
    ;;
esac
path_prepend "${HOME}/.scripts"


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
  "medion") PSCOLOR="$LIGHT_GREEN" ;;
  "squall"*) PSCOLOR="$LIGHT_YELLOW" ;;
  "thunder"*) PSCOLOR="$LIGHT_BLUE" ;;
  *) PSCOLOR="$WHITE" ;;
esac

PS1="$PSCOLOR\W$DEFAULT "
PS2="$PSCOLOR>$DEFAULT "


# environment variables for editor, browser, etc.
first_to_appear() {
  # return the first executable in argument list
  for prog in "$@"; do
    hash "${prog}" &> /dev/null && echo "${prog}" && break
  done
}

export EDITOR="vim"
export PAGER="less"
export BROWSER="$(first_to_appear chromium-browser firefox)"
export IMAGEVIEWER="$(first_to_appear eog "${BROWSER}")"
export PDFVIEWER="$(first_to_appear zathura okular evince "${BROWSER}")"

# MacOS: use open to open files
if [[ "$(uname -s)" == "Darwin" ]]; then
  export {IMAGEVIEWER,PDFVIEWER,BROWSER}="open"
fi


# if existing use hosts-system for ssh host completion
[[ -r '/etc/hosts-system' ]] && export HOSTFILE='/etc/hosts-system'


# python settings
export PYTHONSTARTUP="${HOME}/.pythonrc"

# use anaconda python environment if available
if [[ -d "${HOME}/.anaconda/envs/py35/bin" ]]; then
  path_prepend "${HOME}/.anaconda/envs/py35/bin"
  export CONDA_DEFAULT_ENV="py35"
  export CONDA_ENV_PATH="${HOME}/.anaconda/envs/py35"
fi


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
complete -d ls la ll lR l
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

