function activate {
    local _venv

    _venv=venv

    if [[ ! -z $1 ]]; then    
        _venv=$1
    fi

    source $_venv/bin/activate
}
