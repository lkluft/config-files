# add or edit bash functions

# easy cd ..
u() { cd $(eval printf '../'%.s {1..$1}) && pwd; }

# open man page with colorized less
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[01;31m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# show/search bash history
h(){ history | grep -E "$(echo $@ | sed 's/ /|/g')" ; }

# texmaker shortcut
t(){ texmaker "$@" &> /dev/null & }

# PDF viewer shortcut
pdf(){ $PDFVIEWER "$@" &> /dev/null & }

# command line calculator
=(){ python -c "from math import *; print($*)"; }

# copy output to clipboard
[[ -x /usr/bin/xclip ]] && pbcopy(){ xclip -sel p -f | xclip -sel s -f | xclip -sel c ; }

# Google search via terminal
[[ ! -z $BROWSER ]] && g(){
    qry=$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')
    $BROWSER https://startpage.com/do/search?q=$qry &> /dev/null &
}

# YouTube search via terminal
[[ ! -z $BROWSER ]] && yt(){
    qry=$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')
    $BROWSER http://www.youtube.com/results?search_query=$qry &> /dev/null &
}

