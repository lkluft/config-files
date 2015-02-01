# add or edit bash functions

# change directory and show content
cdl(){ cd $1; ls; }

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

# show/search bash history
h(){ history | grep -E "$(echo $@ | sed 's/ /|/g')" ; }

# texmaker shortcut
t(){ texmaker "$@" &> /dev/null & }

# PDF viewer shortcut
pdf(){ $PDFVIEWER "$@" &> /dev/null & }

# command line calculator
T(){ bc <<< "scale=4;"$@""; }

# fortran compiler
f(){
    if type ifort &> /dev/null;then
        ifort $1 -o ${1%.*}.x
    elif type f95 &> /dev/null;then
        f95 $1 -o ${1%.*}.x
    else
        echo No fortran compiler found.
    fi
}

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

# start matlab and cisco client if needed
mat(){
    # if wifi SSID is "eduroam" start matlab,
    # otherwise establish VPN and start matlab
    if [[ $(iwgetid -r) != "eduroam" ]];then
        # temporary file to store openconnect PID
        temp1=$(mktemp)

        # establish VPN
        sudo openconnect vpn.rrz.uni-hamburg.de \
        --background --user=fgrx245 --pid-file=$temp1 && \
        matlab && \
        sudo kill $(cat $temp1)
    else
        matlab &> /dev/null &
    fi
}
