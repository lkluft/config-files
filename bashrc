# ~/.bashrc: executed by bash(1) for non-login shells.
[[ $- == *i* ]] || return # return if not running interactively


# path settings
[[ $(uname -s) == 'SunOS' ]] && export PATH=/opt/csw/gnu:$PATH
path_append(){ path_remove $1; export PATH="$PATH:$1"; }
path_prepend(){ path_remove $1; export PATH="$1:$PATH"; }
path_remove(){ export PATH=$(echo -n $PATH | \
    awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'); }

case $(hostname) in
    "apple"*)   path_prepend /opt/local/bin
                path_prepend /opt/local/libexec/gnubin
                export SHELL='/opt/local/bin/bash'
                ;;
    "squall"*)  module purge
                module load grads cdo git python/2.7-ve3
                ;;
    "thunder"*) . /scratch/uni/u237/sw/profile.apmet/apmet.sh
                path_prepend $HOME/lkluft/arts/build/src
                export ARTS_DATA_PATH=$APMETSCRATCH/users/lkluft/arts-xml-data
                ;;
esac
path_prepend $HOME/.scripts


# set TMPDIR to /tmp if unset
[[ -z $TMPDIR ]] && export TMPDIR=/tmp


# history settings
HISTCONTROL=ignoreboth # ignore duplicates and lines with leading blank
HISTSIZE=10000
HISTFILESIZE=50000
HISTIGNORE="cd:u:x:h:c:ls:ll:l:la:tm"
PROMPT_COMMAND='history -a'


# prompt settings
case $(hostname) in
    "apple"*)   PS1="\[\033[1;31m\]\W\[\033[0m\] " ;;
    "medion")   PS1="\[\033[1;32m\]\W\[\033[0m\] " ;;
    "squall"*)  PS1="\[\033[1;33m\]\W\[\033[0m\] " ;;
    "thunder"*) PS1="\[\033[1;34m\]\W\[\033[0m\] " ;;
    "acer")     PS1="\[\033[1;36m\]\W\[\033[0m\] " ;;
    *)          PS1="\[\033[1;37m\]\W\[\033[0m\] " ;;
esac


# environment variables for editor, browser, etc.
first_to_appear()
{
    # return the first executable in argument list
    for prog in $@
    do
        hash $prog &> /dev/null && echo $prog && break
    done
}

export EDITOR=vim
export BROWSER=$(first_to_appear chromium-browser firefox)
export IMAGEVIEWER=$(first_to_appear eog $BROWSER)
export PDFVIEWER=$(first_to_appear zathura okular evince $BROWSER)

# MacOS: use open to open files
if [[ $(uname -s) == "Darwin" ]];then
    export {IMAGEVIEWER,PDFVIEWER,BROWSER}=open
fi


# python settings
export PYTHONSTARTUP=$HOME/.pythonrc

# use anaconda python environment if available
if [[ -d ~/.anaconda/envs/py34/bin ]];then
    path_prepend ~/.anaconda/envs/py34/bin
    export CONDA_DEFAULT_ENV=py34
    export CONDA_ENV_PATH=~/.anaconda/envs/py34
fi


# language settings
export {LANG,LANGUAGE}=en_US.utf-8 LC_ALL=C


# shell options
shopt -s cdspell checkwinsize cmdhist globstar histappend

# use physical directory structure instead of symlinks (-P)
# return value of a pipe is zero or the last non-zero status (pipefail)
set -Po pipefail


# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"


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
complete -o plusdirs -f -X '!*.arts' arts
complete -o plusdirs -f -X '!*.tex' latexmk
complete -o plusdirs -f -X '!*.pdf' vpdf
complete -o plusdirs -f -X '!*.@(png|jpg)' vimg
complete -o plusdirs -f -X '!*.tex' t

# enable color support of ls
hash dircolors &> /dev/null && {  [[ -r ~/.dircolors ]] && \
eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)" ; }

# alias definitions. edit in ~/.bash_aliases
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases


# bash functions. edit in ~/.bash_functions
[[ -f ~/.bash_functions ]] && . ~/.bash_functions

