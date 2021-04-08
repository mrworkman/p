# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bullet-train"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export LS_COLORS=$LS_COLORS:'ow=01;94'

BULLETTRAIN_PROMPT_ORDER=(
   time
   status
   custom
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

BULLETTRAIN_CONTEXT_BG=253
BULLETTRAIN_CONTEXT_FG=237

BULLETTRAIN_TIME_BG=241
BULLETTRAIN_TIME_FG=0

BULLETTRAIN_DIR_BG=12
BULLETTRAIN_DIR_FG=0

BULLETTRAIN_EXEC_TIME_BG=220
BULLETTRAIN_EXEC_TIME_FG=232

BULLETTRAIN_GIT_BG=24
BULLETTRAIN_GIT_FG=255

BULLETTRAIN_STATUS_BG=34
BULLETTRAIN_STATUS_ERROR_BG=160
BULLETTRAIN_STATUS_FG=255

BULLETTRAIN_VIRTUALENV_PREFIX=

BULLETTRAIN_STATUS_EXIT_SHOW=true

BULLETTRAIN_DIR_EXTENDED=0
BULLETTRAIN_CONTEXT_HOSTNAME=
BULLETTRAIN_GIT_PROMPT_CMD='$(printf " "; git rev-parse --abbrev-ref HEAD)'
BULLETTRAIN_GIT_EXTENDED=false

export DISPLAY=:0.0

xssh() {
   ssh -C -R6000:localhost:6000 $*
}


alias wgit='/mnt/c/Program\ Files/Git/bin/git.exe'

function git {
   local rwd="$(realpath "$(pwd)")"

   case $rwd in
      /mnt/c/*)
         ;&
      /mnt/d/*)
         wgit "$@"
         ;;
      *)
         command git "$@"
         ;;
   esac
}

function gradlew {
   local cmd='/mnt/c/WINDOWS/system32/cmd.exe'
   local rwd="$(realpath "$(pwd)")"

   case $rwd in
      /mnt/c/*)
         ;&
      /mnt/d/*)
         $cmd /c gradlew.bat "$@"
         ;;
      *)
         if [[ -e $PWD/gradlew ]]; then
             $PWD/gradlew "$@"
         else
            command gradlew "$@"
         fi
         ;;
   esac
}

