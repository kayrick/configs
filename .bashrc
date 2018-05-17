export EDITOR=vim
export BROWSER=google-chrome-stable
export VISUAL=$EDITOR
export LANG=en_US.UTF-8
XTERM_LOCALE=$LANG
export "PS1=[\u@\h:\w]\$ "
which vim > /dev/null || alias vim=vi

alias ls='ls -CF --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias llrt='ls -lrt'
source /etc/environment

[ -e /etc/profile ] && source /etc/profile

PATH=~/bin:$PATH:/sbin/

[ -e .`hostname` ] && source .`hostname`
