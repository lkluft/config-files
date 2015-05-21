# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# PATH settings
path_append ()  { path_remove $1; export PATH="$PATH:$1"; }
path_prepend () { path_remove $1; export PATH="$1:$PATH"; }
path_remove ()  { export PATH=$(echo -n $PATH | \
    awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'); }

case $(hostname) in
    "apple"*)   path_prepend /opt/local/bin
                path_prepend /opt/local/libexec/gnubin
                path_prepend $HOME/.scripts
                export SHELL='/opt/local/bin/bash' ;;
    "squall"*)  path_prepend PATH=$HOME/.scripts
                module load grads cdo git python/2.7-ve0 ;;
    "thunder"*) . /scratch/uni/u237/sw/profile.apmet/apmet.sh
                module load grads cdo intel
                path_prepend /scratch/uni/u237/sw/tmux/bin
                path_prepend $HOME/lkluft/arts/build/src
                path_prepend $HOME/.scripts
                export PYTHONPATH=$HOME/lkluft/Python/lib/python:$PYTHONPATH
                unset LANG ;;
    *)          path_prepend $HOME/.scripts
                path_append /usr/local/MATLAB/R2014b/bin
                path_append /usr/local/MATLAB/R2012a/bin ;;
esac

# history settings
HISTCONTROL=ignoreboth # no duplicates, no lines starting with space
HISTSIZE=10000
HISTFILESIZE=50000
HISTIGNORE="cd:u:x:h:c:ls:ll:l:la:tm"

# disable flow control to enable i-search using Ctrl-s
stty -ixon

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set bash prompt
case $(hostname) in
    "apple"*)   PS1="\[\033[1;31m\]\W\[\033[0m\] " ;;
    "medion")   PS1="\[\033[1;32m\]\W\[\033[0m\] " ;;
    "squall"*)  PS1="\[\033[1;33m\]\W\[\033[0m\] " ;;
    "thunder"*) PS1="\[\033[1;34m\]\W\[\033[0m\] " ;;
    "login"*)   PS1="\[\033[31;47m\]\W\[\033[0m\] " ;;
    "acer")     PS1="\[\033[1;36m\]\W\[\033[0m\] " ;;
    *)          PS1="\[\033[1;37m\]\W\[\033[0m\] " ;;
esac

# new started shells get history of all previous shells
PROMPT_COMMAND='history -a'

# set standard browser and edtior variables
if hash chromium-browser &> /dev/null;then
    BROWSER="chromium-browser --proxy-auto-detect"
elif hash firefox &> /dev/null;then
    BROWSER=firefox
fi

if hash okular &> /dev/null;then
    PDFVIEWER=okular
elif hash evince &> /dev/null;then
    PDFVIEWER=evince
fi

# MacOS: use open as browser/pdf viewer
[[ $(hostname) == "apple"* ]] && { PDFVIEWER=open; BROWSER=open; }

export PDFVIEWER BROWSER EDITOR=vim

# pythonrc location
export PYTHONSTARTUP=$HOME/.pythonrc

# activate virtual python environment
if  [ -f ~/.pyenv/bin/activate ]; then
    path_remove ~/.pyenv/bin
    VIRTUAL_ENV_DISABLE_PROMPT=1 source ~/.pyenv/bin/activate
fi

# shell option behaviour
shopt -s cdspell checkwinsize cmdhist globstar histappend

# set german keyboard configuration for KeePassx auto-fill
[[ $(whoami) == "lukas" ]] && [[ ! -z $DISPLAY  ]] && setxkbmap de

# alias definitions. edit in ~/.bash_aliases
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# bash functions. edit in ~/.bash_functions
[[ -f ~/.bash_functions ]] && . ~/.bash_functions

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# set completion for own scripts and functions
complete -d ls la ll lR l
complete -o plusdirs -f -X '!*.arts'    arts
complete -o plusdirs -f -X '!*.f??'     f
complete -o plusdirs -f -X '!*.tex'     latexmk
complete -o plusdirs -f -X '!*.pdf'     pdf
complete -o plusdirs -f -X '!*.tex'     t

