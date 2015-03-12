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
    "lehre"*)   path_prepend /opt/csw/gnu
                path_prepend $HOME/.scripts
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
HISTSIZE=1000
HISTFILESIZE=5000
HISTIGNORE="cd:u:x:h:c:ls:ll:l:la:tm"

# set colors for man pages (less)
export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[01;36m' # begin bold
export LESS_TERMCAP_me=$'\E[0m'     # end blinking/bold
export LESS_TERMCAP_so=$'\E[01;32m' # begin standout-mode (info box)
export LESS_TERMCAP_se=$'\E[0m'     # end standout-mode
export LESS_TERMCAP_us=$'\E[04;34m' # begin underline
export LESS_TERMCAP_ue=$'\E[0m'     # end underline

# disable flow control to enable i-search using Ctrl-s
stty -ixon

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set bash prompt
case $(hostname) in
    "apple"*)   PS1="\[\033[1;31m\]\W\[\033[0m\] " ;;
    "medion")   PS1="\[\033[1;32m\]\W\[\033[0m\] " ;;
    "lehre"*)   PS1="\[\033[1;33m\]\W\[\033[0m\] " ;;
    "thunder"*) PS1="\[\033[1;34m\]\W\[\033[0m\] " ;;
    "login"*)   PS1="\[\033[31;47m\]\W\[\033[0m\] " ;;
    "acer")     PS1="\[\033[1;36m\]\W\[\033[0m\] " ;;
    *)          PS1="\[\033[1;37m\]\W\[\033[0m\] " ;;
esac

# set standard browser and edtior variables
case $(hostname) in
    "apple"*)   PDFVIEWER=open
                BROWSER=open ;;
    "lehre"*)   PDFVIEWER=evince
                BROWSER=firefox ;;
    "thunder"*) PDFVIEWER=okular
                BROWSER=firefox ;;
            *)  PDFVIEWER=okular
                BROWSER="chromium-browser --proxy-auto-detect" ;;
esac
export PDFVIEWER BROWSER EDITOR=vim

# pythonrc location
export PYTHONSTARTUP=$HOME/.pythonrc

# activate virtual python environment
if  [ -f ~/.pyenv/bin/activate ]; then
    path_remove ~/.pyenv/bin
    VIRTUAL_ENV_DISABLE_PROMPT=1 source ~/.pyenv/bin/activate
fi

# bash behaviour
shopt -s cdspell        # auto-correct typos
shopt -s histappend     # appen to history file, don't overwrite
shopt -s globstar       # ** wildcard matches all subdirectories
shopt -s checkwinsize   # check size of terminal window

# special settings for own machines
if [ $(whoami) == "lukas" ] && [ ! -z $DISPLAY  ];then
    # set german keyboard configuration
    setxkbmap de
fi

# alias definitions. edit in ~/.bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# bash functions. edit in ~/.bash_functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

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
complete -o plusdirs -f -X '!*.pdf' pdf
complete -o plusdirs -f -X '!*.tex' compiletex
complete -o plusdirs -f -X '!*.tex' t
complete -d ls la ll lR l
complete -o plusdirs -f -X '!*.arts' arts

