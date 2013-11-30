export EDITOR=vim
export BROWSER=firefox
export VISUAL=$EDITOR
export LANG=en_US.UTF-8
export TEXINPUTS=/home/kayrick/lib/latex:
export TEXINPUTS_latex=$TEXINPUTS
export TEXINPUTS_pdflatex=$TEXINPUTS
export JAVA_HOME=/usr/lib/jvm/java-6-sun/
XTERM_LOCALE=$LANG
export "PS1=[\u@\h:\w]\$ "
which vim > /dev/null || alias vim=vi

alias ls='ls -CF --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias llrt='ls -lrt'
alias td='today -hu ~/Documents/TODO/*'
source /etc/environment

PATH=$PATH:/home/kayrick/bin
export NEXUS_MAC=00:23:76:9C:A1:E5
export SAL_USE_VCLPLUGIN=gen

GPG_TTY=`tty`
export GPG_TTY 

[ -e .`hostname` ] && source .`hostname`

[ -e /etc/profile ] && source /etc/profile

PATH=~/bin:$PATH:/sbin/

alias armmail='ps aux | grep -v grep | grep davmail > /dev/null || davmail&; mutt -F /home/kayrick/.muttrc.local'

export _JAVA_AWT_WM_NONREPARENTING=1
export STEAM_RUNTIME=1
export AWT_TOOLKIT="MToolkit"
