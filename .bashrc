#!/bin/bash

alias ls='ls --color=always'
alias la='ls -la'
alias rm='rm -i'
alias emacs='emacs -nw'

PS1="\[\033[00m\]\[\e[0;32m\]\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\]\$(if [[ \$? == 0 ]]; then echo \" \[\e[1;32m\]\$\[\e[m\]\"; else echo \" \[\033[0;31m\]\$\[\e[0m\]\"; fi) "
export PS1

. /etc/bash_completion
. /etc/bash_completion.d/git-completion.bash

. $HOME/.bash_completion
