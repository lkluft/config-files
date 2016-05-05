# list of aliases for bash shell

alias c='clear'
alias chrome='chromium-browser'
alias clustertm='ssh cluster -t tmux att -t main'
alias cp='cp -i'
alias df='df -h'
alias free='free -h'
alias grep='grep --color=auto'
alias gvimdiff='gvim -d'
alias ipy='ipython'
alias ipython='INPUTRC=/etc/inputrc ipython --no-banner'
alias ipynb='jupyter notebook'
alias ipyqt='jupyter qtconsole&'
alias l='ls'
alias lR='ls -lFRh'
alias la='ls -lFAh'
alias latexmk='latexmk -e "$pdflatex=q/pdflatex -interaction=nonstopmode/" -pdf'
alias ll='ls -lFh'
alias lrt='ls -lrtFh'
alias ls='ls --color=auto --group-directories-first'
alias mail='mailx'
alias mkdir='mkdir -p'
alias mv='mv -i'
alias p='pwd'
alias rb='sudo reboot'
alias rm='rm -I'
alias root='sudo -i'
alias shut='sudo shutdown -h now'
alias sort='sort -f'
alias sudo='sudo '
alias svim='sudo -e'
alias t7tm='ssh t7 -t /scratch/uni/u237/sw/tmux/bin/tmux att -t main'
alias t='todo.sh -d ~/Dropbox/todo/todo.cfg'
alias topu='top -u $(whoami)'
alias type='type -all'
alias update-conda='conda update --all && conda clean -pt'
alias which='type'
alias x='exit'

