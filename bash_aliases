# list of aliases for bash shell
#
# enable color support of ls and also add handy aliases
which dircolors &> /dev/null && [[ -r ~/.dircolors ]] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

case $(hostname) in
    "acer"|"medion") alias bil='localc ~/Dropbox/Dokumente/Bilanz/Ausgaben_2015.xls &' ;;
esac

alias ls='ls --color=auto --group-directories-first'
alias l='ls'
alias ll='ls -oFh'
alias lrt='ls -ortFh'
alias la='ls -oFAh'
alias lR='ls -oFRh'
alias rm='rm -I'
alias grep='grep --color=auto'
alias p='pwd'
alias pp='pwd -P'
alias mkdir='mkdir -p'
alias x='exit'
alias c='clear'
alias topu='top -u $(whoami)'
alias rb='sudo reboot'
alias shut='sudo shutdown -h now'
alias latexmk='latexmk -e "$pdflatex=q/pdflatex -interaction=nonstopmode/" -pdf'
alias ipy='ipython'
alias ipynb='ipython notebook --script'
alias vim="vim -p"
alias gvim="gvim -p"
alias tmup='eval $(tmux show-env | sed -e /^-/d -e "s/ /\\\ /g" -e "s/^/export /")'

# webpage aliases (edit environment variable BROWSER in ~/.bashrc)
alias fb='$BROWSER https://facebook.com/?sk=h_chr &> /dev/null &'
alias stine='$BROWSER https://www.stine.uni-hamburg.de &> /dev/null &'
