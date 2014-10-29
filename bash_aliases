# list of aliases for bash shell
#
# enable color support of ls and also add handy aliases
which dircolors &> /dev/null && [[ -r ~/.dircolors ]] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

case $(hostname) in
    "apple"*)           alias finder="open -a finder" ;;
    "lehre"*)           alias vim="TERM=xterm-256color vim" ;;
    "acer"|"medion")    alias ipython='BROWSER=chromium-browser ipython'
                        alias bil='localc ~/Dropbox/Dokumente/Bilanz/Ausgaben_2014.xls &' ;;
esac

alias ls='ls --color=auto --group-directories-first'
alias l='ls'
alias ll='ls -oFh'
alias lrt='ls -ortFh'
alias la='ls -oFAh'
alias lR='ls -oFRh'
alias rm='rm -I'
alias grep='grep --color=auto'
alias h='history'
alias p='pwd'
alias mkdir='mkdir -p'
alias x='exit'
alias c='clear'
alias topu='top -u $(whoami)'
alias rb='sudo reboot'
alias shut='sudo shutdown -h now'
alias latexmk='latexmk -pdf'
alias ipnote='ipython notebook --port 4242'

# webpage aliases (edit environment variable BROWSER in ~/.bashrc)
alias fb='$BROWSER facebook.com/?sk=h_chr &> /dev/null &'
alias stine='$BROWSER https://www.stine.uni-hamburg.de &> /dev/null &'
alias sp='$BROWSER https://play.spotify.com/browse &> /dev/null &'
