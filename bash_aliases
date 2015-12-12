# list of aliases for bash shell
#
# enable color support of ls and also add handy aliases
hash dircolors &> /dev/null && {  [[ -r ~/.dircolors ]] && \
eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)" ; }

alias c='clear'
alias clustertm='ssh cluster -t tmux att -t main'
alias cp='cp -i'
alias df='df -h'
alias free='free -h'
alias grep='grep --color=auto'
alias gvimdiff='gvim -d'
alias ipy='INPUTRC=/etc/inputrc bash -c ipython'
alias ipynb='ipython notebook'
alias l='ls'
alias lR='ls -lFRh'
alias la='ls -lFAh'
alias latexmk='latexmk -e "$pdflatex=q/pdflatex -interaction=nonstopmode/" -pdf'
alias less='less -eFsX'
alias ll='ls -lFh'
alias lrt='ls -lrtFh'
alias ls='ls --color=auto --group-directories-first'
alias mail='mailx'
alias mkdir='mkdir -p'
alias mv='mv -i'
alias myip='echo $(curl -s ip.appspot.com)'
alias p='pwd'
alias path='echo -e ${PATH//:/\\n}'
alias rb='sudo reboot'
alias rm='rm -I'
alias root='sudo -i'
alias shut='sudo shutdown -h now'
alias sort='sort -f'
alias sudo='sudo '
alias svim='sudo vim'
alias t7tm='ssh t7 -t /scratch/uni/u237/sw/tmux/bin/tmux att -t main'
alias td='cd $(mktemp -dt bash.XXX)'
alias tdd='cd && find $TMPDIR -maxdepth 1 -user $USER -name "bash.???" -exec rm -rf {} +'
alias todo='todo.sh -d ~/Dropbox/todo/todo.cfg'
alias topu='top -u $(whoami)'
alias type='type -all'
alias which='type'
alias x='exit'

if [[ $(uname -s) == "Darwin" ]]; then
    alias mount_t7='mount_thunder7 && nohup track_thunder7 &> /dev/null &'
    alias umount_t7='mount_thunder7 -u'
fi

# tmux: export the current environment
[[ -z $TMUX ]] || alias tmup='eval $(tmux show-env | sed -e /^-/d -e "s/ /\\\ /g" -e "s/^/export /")'

