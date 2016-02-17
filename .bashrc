export EDITOR=vim
export BROWSER=firefox
export VISUAL=$EDITOR
export LANG=en_US.UTF-8
XTERM_LOCALE=$LANG
export "PS1=[\u@\h:\w]\$ "
which vim > /dev/null || alias vim=vi

alias ls='ls -CF --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias g='grep'
alias llrt='ls -lrt'
source /etc/environment
alias ack=ack-grep

[ -e /etc/profile ] && source /etc/profile

PATH=~/bin:$PATH:/sbin/

export _JAVA_AWT_WM_NONREPARENTING=1
export STEAM_RUNTIME=1
export AWT_TOOLKIT="MToolkit"

[ -e .`hostname` ] && source .`hostname`

export PATH
