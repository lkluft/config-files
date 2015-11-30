# add or edit bash functions

# easy cd ..
u(){ cd $(eval printf '../'%.s {1..$1}) && pwd; }

# open man page with colorized less
man()
{
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

# create backup of the file passed as parameter
bak(){ cp $1{,.bak}; }

# texmaker shortcut
t(){ texmaker "$@" &> /dev/null & }

# PDF viewer shortcut
vpdf(){ $PDFVIEWER "$@" &> /dev/null & }

# image viewer shortcut
vimg(){ $IMAGEVIEWER "$@" &> /dev/null & }

# command line calculator
=(){ python -c "from math import *; print($*)"; }

# copy output to clipboard
[[ -x /usr/bin/xclip ]] && pbcopy(){ xclip -sel p -f | xclip -sel s -f | xclip -sel c ; }

# functions for easier BROWSER access
[[ ! -z $BROWSER ]] &&
{
    # Google search via terminal
    g()
    {
        qry=$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')
        $BROWSER https://startpage.com/do/search?q=$qry &> /dev/null &
    }

    # YouTube search via terminal
    yt()
    {
        qry=$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')
        $BROWSER http://www.youtube.com/results?search_query=$qry &> /dev/null &
    }

    # facebook
    fb(){ $BROWSER https://fb.com/?sk=h_chr &> /dev/null & }

    # WhatsApp
    wa(){ $BROWSER https://web.whatsapp.com &> /dev/null & }

    # go to specific localhost port
    lh(){ $BROWSER localhost:$1 &> /dev/null & }

    # if command line dictionary dict is not present use dict.cc in $BROWSER
    [[ -x /usr/bin/dict ]] || dict()
    {
        qry=$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')
        $BROWSER http://www.dict.cc/?s=$qry &> /dev/null &
    }
}
