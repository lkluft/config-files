# abbreviations
alias c='clear'
alias finger='finger -s'
alias l='ls'
alias la='ls -lFAh'
alias ll='ls -lFh'
alias lrt='ls -lrtFh'
alias p='pwd'
alias ipy='ipython'
alias x='exit'

# default options
alias df='df -h'
alias du='du --human-readable --apparent-size'
alias free='free -h'
alias grep='grep --color=auto'
alias ipython='ipython --no-banner --classic --pprint'
alias latexmk='latexmk -e "$pdflatex=q/pdflatex -interaction=nonstopmode/" -pdf'
alias ls='ls --color=auto --group-directories-first'
alias mkdir='mkdir -p'
alias pgrep='pgrep -l'
alias sort='sort -f'

if [[ "$(uname -s)" == "Linux" ]]; then
  alias open='xdg-open'
fi

alias sudo='sudo '  # Aliases for sudo https://stackoverflow.com/a/37210013
