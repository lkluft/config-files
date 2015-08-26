# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# PATH settings
[[ $(uname -s) == 'SunOS' ]] && export PATH=/opt/csw/gnu:$PATH
path_append ()  { path_remove $1; export PATH="$PATH:$1"; }
path_prepend () { path_remove $1; export PATH="$1:$PATH"; }
path_remove ()  { export PATH=$(echo -n $PATH | \
    awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'); }

case $(hostname) in
    "apple"*)   path_prepend /opt/local/bin
                path_prepend /opt/local/libexec/gnubin
                export SHELL='/opt/local/bin/bash' ;;
    "squall"*)  module load grads cdo git python/2.7-ve3 ;;
    "thunder"*) . /scratch/uni/u237/sw/profile.apmet/apmet.sh
                module load grads cdo intel
                path_prepend $HOME/lkluft/arts/build/src
                [[ -f ~/.anaconda/bin/conda ]] && module unload python
                unset LANG ;;
esac
path_prepend $HOME/.scripts

# history settings
HISTCONTROL=ignoreboth # no duplicates, no lines starting with space
HISTSIZE=10000
HISTFILESIZE=50000
HISTIGNORE="cd:u:x:h:c:ls:ll:l:la:tm"

# new started shells get history of all previous shells
PROMPT_COMMAND='history -a'

# use physical directory structure instead of symlinks (-P)
# return value of a pipe is zero or the last non-zero status (pipefail)
set -Po pipefail

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set bash prompt
case $(hostname) in
    "apple"*)   PS1="\[\033[1;31m\]\W\[\033[0m\] " ;;
    "medion")   PS1="\[\033[1;32m\]\W\[\033[0m\] " ;;
    "squall"*)  PS1="\[\033[1;33m\]\W\[\033[0m\] " ;;
    "thunder"*) PS1="\[\033[1;34m\]\W\[\033[0m\] " ;;
    "acer")     PS1="\[\033[1;36m\]\W\[\033[0m\] " ;;
    *)          PS1="\[\033[1;37m\]\W\[\033[0m\] " ;;
esac

# set standard browser and edtior variables
for browser in {chromium-browser,firefox}
do
    hash $browser &> /dev/null && BROWSER=$browser && break
done

for pdfviewer in {okular,zathura,evince,$BROWSER}
do
    hash $pdfviewer &> /dev/null && PDFVIEWER=$pdfviewer && break
done

# MacOS: use open as browser/pdf viewer
[[ $(hostname) == "apple"* ]] && { PDFVIEWER=open; BROWSER=open; }

export PDFVIEWER BROWSER EDITOR=vim

# pythonrc location
export PYTHONSTARTUP=$HOME/.pythonrc

# use anaconda python environment
if [[ -d ~/.anaconda/envs/python3/bin ]];then
    path_prepend ~/.anaconda/envs/python3/bin
    export CONDA_DEFAULT_ENV=python3
    export CONDA_ENV_PATH=~/.anaconda/envs/python3
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
  if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
  elif [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# set completion for own scripts and functions
complete -d ls la ll lR l
complete -o plusdirs -f -X '!*.arts'    arts
complete -o plusdirs -f -X '!*.tex'     latexmk
complete -o plusdirs -f -X '!*.pdf'     pdf
complete -o plusdirs -f -X '!*.tex'     t

