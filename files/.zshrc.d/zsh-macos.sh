setopt nobeep                   # Silence!
setopt histignorealldups        # If a new command is a duplicate, remove the older one
setopt inc_append_history       # save commands are added to the history immediately, otherwise only when shell exits.

# Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# https://github.com/zsh-users/zsh-history-substring-search
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# https://github.com/zsh-users/zsh-autosuggestions#configuration
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=15"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=220,fg=7"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=1,fg=0"
HISTORY_SUBSTRING_SEARCH_FUZZY=on
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=on
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
