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
                module load git
                module load python/2.7-ve0 ;;
    "thunder"*) export PATH=$HOME/.scripts:$HOME/lkluft/arts/build/src:$PATH
                . /scratch/uni/u237/sw/profile.apmet/apmet.sh
                unset LANG ;;
    *)          export PATH=$HOME/.scripts:$PATH ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100
HISTFILESIZE=500

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set bash prompt
case $(hostname) in
    "acer")     PS1="\[\033[1;34m\]\W\[\033[1;32m\]$\[\033[0m\] " ;;
    "medion")   PS1="\[\033[1;34m\]\W\[\033[1;30m\]$\[\033[0m\] " ;;
    "login"*)   PS1="\[\033[31;34m\]\W\[\033[31;47m\]$\[\033[0m\] " ;;
    "snow"*)    PS1="\[\033[1;34m\]\W\[\033[1;37m\]$\[\033[0m\] " ;;
    "lehre"*)   PS1="\[\033[1;34m\]\W\[\033[1;33m\]$\[\033[0m\] " ;;
    "thunder"*) PS1="\[\033[1;36m\]\W\[\033[1;34m\]$\[\033[0m\] " ;;
    *)          PS1="\[\033[1;34m\]\W\[\033[1;31m\]$\[\033[0m\] " ;;
esac

# set standard browser and edtior variables
case $(hostname) in
    "apple"*)   export PDFVIEWER="open -a preview" ;;
    "lehre"*)   export PDFVIEWER=evince
                export BROWSER=firefox ;;
    "thunder"*) export BROWSER=firefox
                export PDFVIEWER=okular ;;
            *)  export BROWSER="chromium-browser --proxy-auto-detect"
                export PDFVIEWER=okular ;;
esac
export EDITOR=vim

# pythonrc location
export PYTHONSTARTUP=$HOME/.pythonrc

# alias definitions.
# edit in ~/.bash_aliases

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# bash functions
# edit in ~/.bash_functions

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# show date at terminal start
echo $(date +%A), $(date +%x)
case $(date +%H) in
    0[6-9]|1[0-1])  echo Guten Morgen, $USER! ;;
    1[2-9])         echo Guten Tag, $USER! ;;
    2[0-3]|0[0-5])  echo Guten Abend, $USER! ;;
esac

# auto-correct typos/append to history file, don't overwrite
shopt -s cdspell
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
case $(hostname) in
    "apple"*|"lehre"*) ;;
    *)    # If set, the pattern "**" used in a pathname expansion context will
          # match all files and zero or more directories and subdirectories.
          shopt -s globstar
          # auto cd
          shopt -s autocd ;;
esac

if [ $(hostname) == "acer" ]||[ $(hostname) == "medion" ];then
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

# set ssh pass-phrase
#if [ $SSH_AGENT_PID ]; then
#    if [[ $(ssh-add -l) != *id_?sa* ]]; then
#        ssh-add
#    fi
#fi
