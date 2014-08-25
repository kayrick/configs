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
 
# Allow for functions in the prompt.
setopt PROMPT_SUBST

# Autoload zsh functions.
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'

compinit
promptinit; 

PROMPT='%B%F{green}%n@%m%k %B%F{blue}%~ %b%f%k$(prompt_git_info)%B%F{blue}%#%b%f%k '

export ALTERNATE_EDITOR=$EDITOR

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

eval $(gpg-agent --daemon)
