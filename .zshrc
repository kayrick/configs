eval `dircolors -b`

source ~/.bashrc

bindkey -e

setopt NOHUP
setopt NOCHECKJOBS


HISTFILE=$HOME/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt SHAREHISTORY
setopt HIST_REDUCEBLANKS
setopt HIST_EXPIRE_DUPS_FIRST

setopt autocd
setopt hist_ignore_space
setopt hist_ignore_all_dups
unsetopt histreduceblanks

if [ -e $HOME/.ssh/known_hosts ]
then
  hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*})
  zstyle ':completion:*:hosts' hosts $hosts
fi

case $TERM in
    *xterm*|rxvt|(dt|k|E)term)
    preexec () {
    print -Pn "\e]0;[$1] %n@%m: %~\a"
    }
    ;;
esac
zstyle ':completion::complete:*' use-cache 1
autoload -U compinit promptinit

if [ -e /etc/zsh_command_not_found ]
then
  source /etc/zsh_command_not_found
fi
 
compinit
promptinit; 

PROMPT='%B%F{green}%n@%m%k %B%F{blue}%~ %b%f%k%B%F{blue}%#%b%f%k '

export ALTERNATE_EDITOR=$EDITOR

autoload -U edit-command-line
zle -N edit-command-line
