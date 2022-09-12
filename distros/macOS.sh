
function install_homebrew {
   printf "Installig 'homebrew' for user '$user'..."
   o=$(sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash 2>&1)
   r=$?
   print_result_or_die "$o" $r

   # Add homebrew to the current environment.
   eval "$(/opt/homebrew/bin/brew shellenv)"
}

function install_pyenv {
   printf "Installig 'pyenv' for user '$user'..."
   o=$(brew install pyenv 2>&1 > /dev/null)
   r=$?
   print_result_or_die "$o" $r

   # Add pyenv to the current environment
   eval "$(pyenv init -)"
}

function install_python {
   ver=$1
   printf "Installig 'python' $ver for user '$user'..."
   o=$(pyenv install -s "$ver" 2>&1 > /dev/null)
   r=$?
   print_result_or_die "$o" $r
}

function set_python {
   ver=$1
   o=$(pyenv  -s "$ver")
   r=$?
   print_result_or_die "$o" $r
}

install_homebrew
install_pyenv

# Installation of MacOS specific packages should happen below.
# e.g.,
# install_package 'vim' true

install_package htop true
