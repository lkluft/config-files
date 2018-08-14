# add or edit bash functions


## auxiliary functions (needed by other functions)

# check if variable is set
_check_var(){
  [[ -z "${!1}" ]] && _err "${1} not set." && return 1
  return 0
}


# print _error message to STDERR
_err() {
  >&2 echo "ERROR: $1";
}


## user functions

# create backup of the file passed as parameter
bak() {
  cp -ir $1{,.bak}
}

# clean ExecuteTimes from Jupyter Notebooks
clean_execute() {
    sed -n -i -e '1!H;1h;${x;s/ *"ExecuteTime": {[^}]*},//g;p}' "$@"
}

# Display colon-separated variables in a nicer format.
decol() {
    echo -e ${!1//:/\\n};
}

# if command line dictionary dict is not present use dict.cc in $BROWSER
if ! hash dict &> /dev/null; then
  dict() {
    _check_var BROWSER || return 1;
    local qry="$(echo "$@" | sed -e 's/+/%2B/g' -e 's/ /+/g')";
    ${BROWSER} "http://www.dict.cc/?s=${qry}" &> /dev/null &
  }
fi


# extract archive depending on file extension
extract() {
  if [[ -z "$1" ]]; then
    # display usage if no parameters given
    echo "Usage: extract <path/to/archive>"
  else
    if [[ -f "$1" ]] ; then
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
        *)           echo "extract: $1 - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}


# facebook
fb() {
  _check_var BROWSER || return 1;
  ${BROWSER} "https://fb.com/?sk=h_chr" &> /dev/null &
}


# Google search via terminal
g() {
  _check_var BROWSER || return 1;
  local qry="$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')"
  ${BROWSER} "https://startpage.com/do/search?q=${qry}" &> /dev/null &
}


# put current directory under version control (git)
gitpwd() {
  [[ -d ".git" ]] || { git init && git add .; }
}


# open Google Mail in web browser
gmail() {
  _check_var BROWSER || return 1;
  ${BROWSER} "https://mail.google.com" &> /dev/null &
}


# open Google Mail in web browser
gcal() {
  _check_var BROWSER || return 1;
  ${BROWSER} "https://calendar.google.com" &> /dev/null &
}


# show/search bash history
h() {
  history | grep -E "$(echo "$@" | sed 's/ /|/g')"
}


# count files in given directory (defaults to "./")
lc() {
  case "$#" in
    0) command ls -U | wc -l ;;
    1) command ls -U "$1" | wc -l ;;
    *)
      for d in "$@"; do
        echo "${d}": "$(command ls -U "${d}" | wc -l)"
      done
    ;;
  esac
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
    man "$@";
}
# export man to use it through vim
export -f man


# print the current IP
myip() {
  echo "$(curl -s ip.appspot.com)"
}


# print the content of PATH
path() {
  decol PATH
}


# ping google.com three times
pingg() {
  ping -c 3 -i 0.2 "google.com"
}


# copy output to clipboard
if hash xclip &> /dev/null; then
  pbcopy() {
    xclip -sel p -f | xclip -sel s -f | xclip -sel c
  }
fi


# take a screenshot from command line
if [[ "$(uname -s)" == "Darwin" ]]; then
  scrot() {
    local date="$(date +%F_%H%M%S)"
    case "$1" in
      -i) screencapture -i "${date}_selection.png" ;;
      -w) screencapture -w "${date}_window.png" ;;
      *)  screencapture "${date}.png" ;;
    esac
  }
elif [[ "$(uname -s)" == "Linux" ]]; then
  scrot() {
    [[ -z "$2" ]] && delay=3 || delay="$2";
    local date="$(date +%F_%H%M%S)"
    case "$1" in
      -i) gnome-screenshot -a -f "${date}_selection.png" ;;
      -w) gnome-screenshot -w -d "${delay}" -f "${date}_window.png" ;;
      *)  gnome-screenshot -f "${date}.png" ;;
    esac
  }
fi


# create a temporary directory and change into it
tmp() {
  [[ -f ~/.tmpdir ]] || mktemp -dt bash.XXX > ~/.tmpdir
  cd "$(cat ~/.tmpdir)"
}


# delete temporary directory created with td
tmprm() {
  [[ -f ~/.tmpdir ]] || return 0;
  local tmpdir="$(readlink -f $(cat ~/.tmpdir))"  # absolut path to tmpdir
  [[ "${PWD}" == "${tmpdir}" ]] && cd  # change from tmpdir before removing
  rm -rf "${tmpdir}" && rm ~/.tmpdir
}


# update env in a tmux session
tmup() {
  _check_var TMUX || return 1;
  eval "$(tmux show-env | sed -e /^-/d -e 's/ /\\\ /g' -e 's/^/export /')"
}


# easy cd ..
u() {
  cd "$(eval printf '../'%.s {1..$1})" && pwd
}


# image viewer shortcut
_view_img() {
  _check_var IMAGEVIEWER || return 1;
  ${IMAGEVIEWER} "$@" &> /dev/null &
}


# PDF viewer shortcut
_view_pdf() {
  _check_var PDFVIEWER || return 1;
  ${PDFVIEWER} "$@" &> /dev/null &
}


# open each file given in a list depending on its extension
o() {
  for file in "$@"; do
    # lower case before matching the extension
    case "${file,,}" in
      *.pdf) _view_pdf "${file}" ;;
      *.png) _view_img "${file}" ;;
      *.jpg) _view_img "${file}" ;;
      *) _err "'${file}' unknown file type" ;;
    esac
  done
}


# kill user process by name
pskill() {
  pkill "$@" -U $USER
}

# grep for active processes
psgrep() {
  ps aux | grep -E "$(echo "$@" | sed 's/ /|/g')"
}

# share files via Dropbox
share-dropbox() {
  dropbox_dir="${HOME}/Dropbox/Shared/"
  [[ -d ${dropbox_dir} ]] || _err "Could'nt find ${dropbox_dir}."

  \cp -fr "$@" "${dropbox_dir}"
}

# add a useful svn log
svnlog() {
  svn log -v "$@" | less
}

# convert a PDF document with two pages side-by-side (printer friendly)
twocolumn() {
  for file in "$@"; do
    if [[ ${file##*.} != "pdf" ]]; then
        _err "${file} is no PDF document."
    else
        pdfjam -q --landscape --nup 2x1 \
            "${file}" -o "${file%.*}-printified.pdf"
    fi
  done
}

# WhatsApp
wa() {
  _check_var BROWSER || return 1;
  ${BROWSER} "https://web.whatsapp.com" &> /dev/null &
}

# current weather information
wttr() {
    if [[ -z $1 ]]; then
        curl -s wttr.in | head -n 7 | tail -n +3
    else
        curl -s wttr.in/$1
    fi
}


# YouTube search via terminal
yt() {
  _check_var BROWSER || return 1;
  local q="$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')";
  ${BROWSER} "https://www.youtube.com/results?search_query=${q}" &> /dev/null &
}
