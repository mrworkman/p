export DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/lib:$DYLD_FALLBACK_LIBRARY_PATH

if [[ "$HOMEBREW_PREFIX" != "" ]]; then
    return 0
fi

# Remove any homebrew paths that are already in PATH.
path=(${path[@]:#*homebrew*})

path=(/opt/homebrew/bin /opt/homebrew/sbin $path)

if [[ -e /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
