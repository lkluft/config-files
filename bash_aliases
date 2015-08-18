# list of aliases for bash shell
#
# enable color support of ls and also add handy aliases
hash dircolors &> /dev/null && {  [[ -r ~/.dircolors ]] && \
eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)" ; }

alias c='clear'
alias grep='grep --color=auto'
alias gvim='gvim --remote-tab-silent'
alias ipy='INPUTRC=/etc/inputrc bash -c ipython'
alias ipynb='ipython notebook'
alias l='ls'
alias lR='ls -oFRh'
alias la='ls -oFAh'
alias latexmk='latexmk -e "$pdflatex=q/pdflatex -interaction=nonstopmode/" -pdf'
alias less='less -eFsX'
alias ll='ls -oFh'
alias lrt='ls -ortFh'
alias ls='ls --color=auto --group-directories-first'
alias mkdir='mkdir -p'
alias myip='curl -s ip.appspot.com'
alias p2='source activate python2'
alias p3='source activate python3'
alias p='pwd'
alias rb='sudo reboot'
alias rm='rm -I'
alias shut='sudo shutdown -h now'
alias sudo='sudo '
alias t7='ssh t7 -t /scratch/uni/u237/sw/tmux/bin/tmux att -t main'
alias tmup='eval $(tmux show-env | sed -e /^-/d -e "s/ /\\\ /g" -e "s/^/export /")'
alias topu='top -u $(whoami)'
alias type='type -all'
alias update-conda='conda update -y --all && conda clean -y -p && conda clean -y -t'
alias vim='vim -p'
alias which='type'
alias x='exit'

if [[ $(hostname) == "apple"* ]]; then
    alias mount_t7='mount_thunder7 && nohup track_thunder7 &> /dev/null &'
    alias umount_t7='mount_thunder7 -u'
fi

# webpage aliases (edit environment variable BROWSER in ~/.bashrc)
[[ ! -z $BROWSER ]] && alias fb='$BROWSER https://fb.com/?sk=h_chr &> /dev/null &'

