# list of aliases for bash shell
#
# enable color support of ls and also add handy aliases
which dircolors &> /dev/null && [[ -r ~/.dircolors ]] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

# UNIX-Kurzbefehle
case $(hostname) in
    "apple"*)   alias finder="open -a finder" ;;
    "lehre"*)   alias vim="TERM=xterm-256color vim" ;;
esac

alias ls='ls --color=auto --group-directories-first'
alias rm='rm -I'
alias l='ls'
alias ll='ls -oFh'
alias lrt='ls -ortFh'
alias la='ls -oFAh'
alias lR='ls -oFRh'
alias grep='grep --color=auto'
alias h='history'
alias p='pwd'
alias mkdir='mkdir -p'
alias x='exit'
alias c='clear'

# Systeminformationen
alias topu='top -U $(whoami)'
alias temp='sensors | grep °C | head -3'

# sudo Kurzbfehle
alias rb='sudo reboot'

# Programme
alias latexmk='latexmk -pdf'
if [[ $(hostname) == "medion" ]] || [[ $(hostname) == "acer" ]];then
    alias ipython='BROWSER=chromium-browser ipython'
fi
alias ipnote='ipython notebook --port 4242'
#
alias bil='localc ~/Dropbox/Dokumente/Bilanz/Ausgaben_2014.xls &'


# Internetkurzbefehle (Browser in ~/.bashrc editieren)
alias fb='nohup $BROWSER facebook.com/?sk=h_chr &> /dev/null &'
alias stine='nohup $BROWSER https://www.stine.uni-hamburg.de &> /dev/null &'
alias sp='nohup $BROWSER https://play.spotify.com/browse &> /dev/null &'

# SSH-Verbindung
#alias uni_info='ssh -X xkluft@rzssh1.informatik.uni-hamburg.de'
