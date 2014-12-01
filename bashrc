# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# PATH settings
case $(hostname) in
    "apple"*)   export PATH=$HOME/.scripts:/opt/local/libexec/gnubin:/opt/local/bin:$PATH ;;
    "lehre"*)   export PATH=$HOME/.scripts:/opt/csw/gnu:$PATH
                module load grads cdo git python/2.7-ve0
                export TERM=xterm ;;
    "thunder"*) export PATH=$HOME/.scripts:$HOME/lkluft/arts/build/src:$PATH
                . /scratch/uni/u237/sw/profile.apmet/apmet.sh
                module load grads cdo
                unset LANG ;;
    *)          export PATH=$HOME/.scripts:$PATH ;;
esac

# history settings
HISTCONTROL=ignoreboth # no duplicates, no lines starting with space
HISTSIZE=1000
HISTFILESIZE=5000
HISTIGNORE="cd:u:x:h:c:ls:ll:l"

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
    "acer")     PS1="\[\033[1;34m\]\W\[\033[1;32m\]$\[\033[0m\] " ;;
    "medion")   PS1="\[\033[1;34m\]\W\[\033[1;32m\]>\[\033[0m\] " ;;
    "login"*)   PS1="\[\033[31;34m\]\W\[\033[31;47m\]$\[\033[0m\] " ;;
    "snow"*)    PS1="\[\033[1;34m\]\W\[\033[1;37m\]$\[\033[0m\] " ;;
    "lehre"*)   PS1="\[\033[1;34m\]\W\[\033[1;33m\]$\[\033[0m\] " ;;
    "thunder"*) PS1="\[\033[1;36m\]\W\[\033[1;34m\]$\[\033[0m\] " ;;
    *)          PS1="\[\033[1;34m\]\W\[\033[1;31m\]$\[\033[0m\] " ;;
esac

# set standard browser and edtior variables
case $(hostname) in
    "apple"*)   export PDFVIEWER=open
                export BROWSER=open ;;
    "lehre"*)   export PDFVIEWER=evince
                export BROWSER=firefox ;;
    "thunder"*) export PDFVIEWER=okular
                export BROWSER=firefox ;;
            *)  export PDFVIEWER=okular
                export BROWSER="chromium-browser --proxy-auto-detect" ;;
esac
export EDITOR=vim

# pythonrc location
export PYTHONSTARTUP=$HOME/.pythonrc

# alias definitions. edit in ~/.bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# bash functions. edit in ~/.bash_functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# auto-correct typos/append to history file, don't overwrite
shopt -s cdspell
shopt -s histappend

# update the values of LINES and COLUMNS after each command
shopt -s checkwinsize

# special settings for own machines
if [ $(whoami) == "lukas" ]&&[ ! -z $DISPLAY  ];then
    # set german keyboard configuration
    setxkbmap de
    if [ $(hostname) == "acer" ];then
        # disconnect phantom VGA screen
        vga-disconnect
    fi
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
