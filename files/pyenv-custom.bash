function is_in_list {
  looking_for="$1"

  shift
  list=("$@")

  for v in "${list[@]}"; do
    if [[ "$v" == "$looking_for" ]]; then
      return 0
    fi
  done

  return 1
}

if [[ -n "$PYENV_COMMAND" && ! -x "$PYENV_COMMAND_PATH" ]]; then
  versions=($(pyenv-whence "${PYENV_COMMAND}" 2>/dev/null || true))

  # Uses the last value returned form `pyenv whence`.
  _set="${versions[@]: -1}"

  _local=$(pyenv 'local' | head -n 1)  
  _global=$(pyenv 'global' | head -n 1)

  if [[ -n "${versions}" ]]; then

    # If there are multiple matches, try local, then global, then default.
    # Otherwise, use whatever the last item in the list of versions is.

    if [[ "${#versions[@]}" -gt 1 ]]; then

      if is_in_list "$_local" "${versions[@]}"; then
        _set="$_local"
      elif is_in_list "$_global" "${versions[@]}"; then
        _set="$_global"
      elif is_in_list "default" "${versions[@]}"; then
        _set="default"
      fi
    
      tput setaf 11
      echo "Found multiple instances of \`${PYENV_COMMAND}\` in pyenv." \
           "Using version: ${_set}."
      tput sgr0
    fi >&2

    PYENV_COMMAND_PATH="${PYENV_ROOT}/versions/${_set}/bin/${PYENV_COMMAND}"

  fi
fi
