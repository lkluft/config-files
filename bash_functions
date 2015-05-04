# add or edit bash functions

# easy cd ..
u(){
    if [ -z $1 ];then
        LIMIT=1
    else
        LIMIT=$1
    fi
    P="$PWD"
    for ((i=1; i <= LIMIT; i++))
    do
        P="$P/.."
    done
    cd "$P"
}

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

# functions depending on BROWSER variable (set in ~/.bashrc)
if [[ ! -z $BROWSER ]]; then
    # Google/YouTube search via terminal
    g(){
        $BROWSER \
        "https://startpage.com/do/search?q=$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')" \
        &> /dev/null &
    }

    yt(){
        $BROWSER \
        "http://www.youtube.com/results?search_query=$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')" \
        &> /dev/null &
    }
fi

# fortran compiler
f(){
    [[ -z $1 ]] && { echo ERROR: No file to compile.; return 1; }
    if hash ifort &> /dev/null;then
        ifort $1 -o ${1%.*}
    elif hash f95 &> /dev/null;then
        f95 $1 -o ${1%.*}
    elif hash f90 &> /dev/null;then
        f90 $1 -o ${1%.*}
    else
        echo ERROR: No fortran compiler found.
        return 1
    fi
    return 0
}

# # start matlab and cisco client if needed
# mat(){
#     # if wifi SSID is "eduroam" start matlab,
#     # otherwise establish VPN and start matlab
#     if [[ $(iwgetid -r) != "eduroam" ]];then
#         # temporary file to store openconnect PID
#         temp1=$(mktemp)
#
#         # establish VPN
#         sudo openconnect vpn.rrz.uni-hamburg.de \
#         --background --user=fgrx245 --pid-file=$temp1 && \
#         matlab && \
#         sudo kill $(cat $temp1)
#     else
#         matlab &> /dev/null &
#     fi
# }
#
# # smsvongesternnacht.de in terminal
# smsvongesternnacht(){
# tmp=$(mktemp)
# [[ -z $1 ]] || [[ $1 == "zufall" || $1 == "beste" ]] || return 1
# curl -s http://www.smsvongesternnacht.de/$1?page={0..10} >> $tmp
# grep -E "(\"sms-bubble\")|(\"sms-tag\")|(\"field-item odd\")|(sms-participant)|(class=\"sms-tagline)" $tmp | \
# sed -e 's/\r//g' \
#     -e 's/.*<div class="sms-participant sms-participant-1">.*/\"\\n\\033\[1;31m\"/' \
#     -e 's/.*<div class="sms-participant sms-participant-2">.*/\"\\n\\033[1;32m\"/' \
#     -e 's/<div class="sms-tag">/\"/' \
#     -e 's/<div class="sms-bubble">/\"/' \
#     -e 's:</div>:\":' \
#     -e 's/.*<aside class="sms-tagline">.*/\"\\033\[0m\\n\\n\"/' \
#     -e 's/\&#......;//g' | \
# xargs echo -e | less -R
# }

