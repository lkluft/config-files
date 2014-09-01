# list of aliases for bash shell
#
# enable color support of ls and also add handy aliases
which dircolors &> /dev/null && [[ -r ~/.dircolors ]] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

# UNIX-Kurzbefehle
if [[ $(hostname) == "apple"* ]];then
    alias finder="open -a finder"
fi
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
alias gnu='gnuplot'
alias sp='spotify &> /dev/null &'
#
alias bil='localc ~/Dropbox/Dokumente/Bilanz/Ausgaben_2014.xls &'


# Internetkurzbefehle (Browser in ~/.bashrc editieren)
alias fb='nohup $BROWSER facebook.com/?sk=h_chr &> /dev/null &'
alias stine='nohup $BROWSER https://www.stine.uni-hamburg.de > /dev/null 2>&1&'
alias ping='ping google.com -c 3'

# SSH-Verbindung
alias login1='ssh -X u300509@login1.zmaw.de'
alias thun='ssh -X thunder7'
alias lehre='ssh -X lehre2'
#alias uni_info='ssh -X xkluft@rzssh1.informatik.uni-hamburg.de'
