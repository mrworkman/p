setopt nobeep                   # Silence!
setopt histignorealldups        # If a new command is a duplicate, remove the older one
setopt inc_append_history       # save commands are added to the history immediately, otherwise only when shell exits.
setopt noautocd

# Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# https://github.com/zsh-users/zsh-history-substring-search
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# https://github.com/zsh-users/zsh-autosuggestions#configuration
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=253"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=220,fg=0"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=red,fg=white,bold"
HISTORY_SUBSTRING_SEARCH_FUZZY=on
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=on
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

local_bin="$HOME/.local/bin"

if [[ ! -e "$local_bin" ]]; then
    mkdir -p "$local_bin"
fi

if [[ ! $path =~ ${local_bin//\./\\.} ]]; then
    path=("$local_bin" $path)
fi

unset local_bin

# Enable additional ZSH completions.
if type brew &>/dev/null; then
   BREW_PATH=$(brew --prefix)
   FPATH=$BREW_PATH/share/zsh-completions:$FPATH
   FPATH=$BREW_PATH/share/zsh/site-functions:$FPATH

   chmod go-w /opt/homebrew/share
   chmod -R go-w /opt/homebrew/share/zsh

   autoload -Uz compinit
   rm -f ~/.zcompdump; compinit
fi
