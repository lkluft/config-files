# add or edit bash functions

# print _error message to STDERR
_err() {
  >&2 echo "ERROR: $1";
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
    local qry="$(echo "$@" | sed -e 's/+/%2B/g' -e 's/ /+/g')";
    open "http://www.dict.cc/?s=${qry}" &> /dev/null &
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


# Google search via terminal
g() {
  local qry="$(echo $@ | sed -e 's/+/%2B/g' -e 's/ /+/g')"
  open "https://startpage.com/do/search?q=${qry}" &> /dev/null &
}


# open Google Mail in web browser
gmail() {
  open "https://mail.google.com" &> /dev/null &
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


# print the content of PATH
path() {
  decol PATH
}


# ping google.com three times
pingg() {
  ping -c 3 -i 0.2 "google.com"
}


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


# update env in a tmux session
tmup() {
  [[ -z ${TMUX} ]] && return 1;
  eval "$(tmux show-env | sed -e /^-/d -e 's/ /\\\ /g' -e 's/^/export /')"
}


# easy cd ..
u() {
  cd "$(eval printf '../'%.s {1..$1})" && pwd
}


# share files via Dropbox
share-dropbox() {
  dropbox_dir="${HOME}/Dropbox/Shared/"
  [[ -d ${dropbox_dir} ]] || _err "Could'nt find ${dropbox_dir}."

  \cp -fr "$@" "${dropbox_dir}"
}


# Store currently used Mistral preprocessing node to file.
set-pphost(){ hostname > ~/.pphost; }

# Open ``top`` with own processes only.
topu(){ top -U ${USER}; }

# Update conda environment.
update-conda(){ conda update --all && conda clean -pty; }

# Update MacPorts.
update-macports(){ sudo port selfupdate && sudo port upgrade outdated; }

# Connect to tmux servers on remote machines.
pptm(){ ssh mistralpp -t /work/um0878/sw/anaconda/bin/tmux att -t main; }
t7tm(){ ssh t7 -t /scratch/uni/u237/sw/tmux/bin/tmux att -t main; }

# Start Python interpreter without reading configuration file.
ipyplain() { PYTHONSTARTUP="" ipy; }
