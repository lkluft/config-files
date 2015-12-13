# add or edit bash functions

# create backup of the file passed as parameter
bak(){ cp $1{,.bak}; }


# if command line dictionary dict is not present use dict.cc in $BROWSER
[[ -z $BROWSER ]] || [[ -x /usr/bin/dict ]] || dict()
{
    qry=$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')
    $BROWSER http://www.dict.cc/?s=$qry &> /dev/null &
}


# extract archive depending on file extension
extract()
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
[[ -z $BROWSER ]] || fb(){ $BROWSER https://fb.com/?sk=h_chr &> /dev/null & }


# put current directory under version control (git)
git.(){ [[ -d .git ]] || { git init && git add .; }; }


# Google search via terminal
[[ -z $BROWSER ]] || g()
{
    qry=$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')
    $BROWSER https://startpage.com/do/search?q=$qry &> /dev/null &
}


# show/search bash history
h(){ history | grep -E "$(echo $@ | sed 's/ /|/g')"; }


# go to specific localhost port
[[ -z $BROWSER ]] || lh(){ $BROWSER http://localhost:$1 &> /dev/null & }


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
    man "$@";
}


# mount thunder7 directories and keep track of them
[[ $(uname -s) == "Darwin" ]] && mount_t7()
{
    mount_thunder7
    nohup track_thunder7 &> /dev/null &
}


# print the current IP
myip(){ echo $(curl -s ip.appspot.com); }


# print the content of PATH
path(){ echo -e ${PATH//:/\\n}; }


# ping google.com three times
pingg(){ ping -c 3 -i 0.2 google.com; }

# copy output to clipboard
[[ -x /usr/bin/xclip ]] && pbcopy()
{
    xclip -sel p -f | xclip -sel s -f | xclip -sel c;
}


# create a temporary directory and change into it
td(){ cd $(mktemp -dt bash.XXX); }


# delete all temporary directories created with td
tdd()
{
    cd $HOME
    find $TMPDIR -maxdepth 1 -user $USER -name "bash.???" -exec rm -rf {} +;
}


# updated env in a tmux session
tmup()
{
    [[ -z TMUX ]] || return
    eval $(tmux show-env | sed -e /^-/d -e "s/ /\\\ /g" -e "s/^/export /");
}


# easy cd ..
u(){ cd $(eval printf '../'%.s {1..$1}) && pwd; }


# image viewer shortcut
[[ -z $IMAGEVIEWER ]] || vimg(){ $IMAGEVIEWER "$@" &> /dev/null & }


# PDF viewer shortcut
[[ -z $PDFVIEWER ]] || vpdf(){ $PDFVIEWER "$@" &> /dev/null & }


# command line calculator
pc(){ python -c "from math import *; print($*)"; }


# WhatsApp
[[ -z $BROWSER ]] || wa(){ $BROWSER https://web.whatsapp.com &> /dev/null & }


# YouTube search via terminal
[[ -z $BROWSER ]] || yt()
{
    q=$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')
    $BROWSER https://www.youtube.com/results?search_query=$q &> /dev/null &
}
