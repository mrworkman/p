if [[ -e /opt/homebrew/bin/pyenv && -z "$PYENV_SHELL" ]]; then
    eval "$(pyenv init -)"
fi
