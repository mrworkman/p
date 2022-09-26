# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bullet-train"
CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder
PROMPT_EOL_MARK=" "

plugins=(
   git
   npm
   colored-man-pages
   aws
)

source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export LS_COLORS=$LS_COLORS:'ow=01;94'

BULLETTRAIN_PROMPT_ORDER=(
   custom
   time
   status
   context
   dir
   perl
   ruby
   virtualenv
   # nvm
   aws
   go
   elixir
   git
   hg
   cmd_exec_time
)

_dot_d=$HOME/.zshrc.d

# Load additional settings, if any.
if [[ -d $_dot_d ]]; then
   ls $_dot_d | while read _file; do
      if [[ $_file =~ \.sh$ ]]; then
         source "$_dot_d/$_file"
      fi
   done
fi

unset _dot_d _file

# Automatically find new executables in path
zstyle ':completion:*' rehash true
