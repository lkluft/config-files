# add or edit bash functions

# create backup of the file passed as parameter
bak ()
{
    cp $1{,.bak}
}


# if command line dictionary dict is not present use dict.cc in $BROWSER
if ! hash xclip &> /dev/null;then
    dict ()
    {
        [[ -z $BROWSER ]] && echo "ERROR: BROWSER not set." && return 1;
        qry=$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g');
        $BROWSER http://www.dict.cc/?s=$qry &> /dev/null &
    }
fi


# extract archive depending on file extension
extract ()
{
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/to/archive>"
    else
        if [ -f "$1" ] ; then
            NAME=${1%.*}
            case "$1" in
                *.tar.bz2)   tar xjf ./"$1" ;;
                *.tar.gz)    tar xzf ./"$1" ;;
                *.tar.xz)    tar xJf ./"$1" ;;
                *.lzma)      unlzma ./"$1" ;;
                *.bz2)       bunzip2 ./"$1" ;;
                *.rar)       unrar x -ad ./"$1" ;;
                *.gz)        gunzip ./"$1" ;;
                *.tar)       tar xf ./"$1" ;;
                *.tbz2)      tar xjf ./"$1" ;;
                *.tgz)       tar xzf ./"$1" ;;
                *.zip)       unzip ./"$1" ;;
                *.Z)         uncompress ./"$1" ;;
                *.7z)        7z x ./"$1" ;;
                *.xz)        unxz ./"$1" ;;
                *.exe)       cabextract ./"$1" ;;
                *)           echo "extract: '$1' - unknown archive method" ;;
            esac
        else
            echo "'$1' - file does not exist"
    fi
fi
}


# facebook
fb ()
{
    [[ -z $BROWSER ]] && echo "ERROR: BROWSER not set." && return 1;
    $BROWSER https://fb.com/?sk=h_chr &> /dev/null &
}


# Google search via terminal
g ()
{
    [[ -z $BROWSER ]] && echo "ERROR: BROWSER not set." && return 1;
    qry=$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')
    $BROWSER https://startpage.com/do/search?q=$qry &> /dev/null &
}


# put current directory under version control (git)
git. ()
{
    [[ -d .git ]] || { git init && git add .; }
}


# show/search bash history
h ()
{
    history | grep -E "$(echo $@ | sed 's/ /|/g')"
}


# go to specific localhost port
lh ()
{
    [[ -z $BROWSER ]] && echo "ERROR: BROWSER not set." && return 1;
    $BROWSER http://localhost:$1 &> /dev/null &
}


# open man page with colorized less
man ()
{
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[01;31m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@";
}


# mount thunder7 directories and keep track of them
if [[ $(uname -s) == "Darwin" ]];then
    mount_t7 ()
    {
        mount_thunder7
        nohup track_thunder7 &> /dev/null &
    }
fi


# print the current IP
myip ()
{
    echo $(curl -s ip.appspot.com)
}


# print the content of PATH
path ()
{
    echo -e ${PATH//:/\\n}
}


# ping google.com three times
pingg ()
{
    ping -c 3 -i 0.2 google.com
}


# copy output to clipboard
if ! hash xclip &> /dev/null;then
    pbcopy ()
    {
        xclip -sel p -f | xclip -sel s -f | xclip -sel c
    }
fi


# take a screenshot from command line
if [[ $(uname -s) == "Darwin" ]];then
    scrot ()
    {
        case $1 in
            -i) screencapture $1 $(date +%F_%H%M%S)_selection.png ;;
            -w) screencapture $1 $(date +%F_%H%M%S)_window.png ;;
            *)  screencapture $1 $(date +%F_%H%M%S).png ;;
        esac
    }
fi


# create a temporary directory and change into it
td ()
{
    cd $(mktemp -dt bash.XXX)
}


# delete all temporary directories created with td
tdd ()
{
    cd $HOME
    find $TMPDIR -maxdepth 1 -user $USER -name "bash.???" -exec rm -rf {} +
}


# updated env in a tmux session
tmup ()
{
    [[ -z $TMUX ]] && echo "ERROR: Not attached to tmux session." && return 1;
    eval $(tmux show-env | sed -e /^-/d -e "s/ /\\\ /g" -e "s/^/export /")
}


# easy cd ..
u ()
{
    cd $(eval printf '../'%.s {1..$1}) && pwd
}


# image viewer shortcut
vimg ()
{
    [[ -z $IMAGEVIEWER ]] && echo "ERROR: IMAGEVIEWER not set." && return 1;
    $IMAGEVIEWER "$@" &> /dev/null &
}


# PDF viewer shortcut
vpdf ()
{
    [[ -z $PDFVIEWER ]] && echo "ERROR: PDFVIEWER not set." && return 1;
    $PDFVIEWER "$@" &> /dev/null &
}


# command line calculator
pc ()
{
    python -c "from math import *; print($*)";
}


# WhatsApp
wa ()
{
    [[ -z $BROWSER ]] && echo "ERROR: BROWSER not set." && return 1;
    $BROWSER https://web.whatsapp.com &> /dev/null &
}


# YouTube search via terminal
yt ()
{
    [[ -z $BROWSER ]] && echo "ERROR: BROWSER not set." && return 1;
    q=$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g');
    $BROWSER https://www.youtube.com/results?search_query=$q &> /dev/null &
}
