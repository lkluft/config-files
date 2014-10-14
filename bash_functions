# add or edit bash functions
# fortran compiler
f(){ f95 $1 -o ${1%.*}.x; }

# Google/YouTube search via terminal
g() {
    $BROWSER \
    "https://startpage.com/do/search?q=$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')" \
    &> /dev/null & 
}

yt(){
    $BROWSER \
    "http://www.youtube.com/results?search_query=$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')" \
    &> /dev/null &
}

# texmaker shortcut
t(){ texmaker "$@" &> /dev/null &}

# PDF viewer shortcut
pdf(){ $PDFVIEWER "$@" &> /dev/null & }

# command line calculator
T(){ bc <<< "scale=4;"$@""; }

# easy cd ..
u() {
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

# start matlab and cisco client if needed
mat() {
    # check if cisco vpnui is already running
    ps -e | grep -v grep | grep vpnui &> /dev/null
    result=$?

    # if cisco is running start matlab, otherwise start both processes
    if [ $result = 1 ];then
        /opt/cisco/anyconnect/bin/vpnui &> /dev/null &
        cd ~/Datenverarbeitung/Matlab
        /usr/local/MATLAB/R20*/bin/matlab &
    else
        cd ~/Datenverarbeitung/Matlab
        /usr/local/MATLAB/R20*/bin/matlab &
    fi
}
