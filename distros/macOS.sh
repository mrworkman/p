#!/usr/bin/env bash

function install_homebrew {
   printf "Installig 'homebrew' for user '$user'..."
   o=$(sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash 2>&1)
   r=$?
   print_result_or_die "$o" $r

   # Add homebrew to the current environment.
   eval "$(/opt/homebrew/bin/brew shellenv)"
}

function install_pip2 {
   printf "Installig 'pip2' for user '$user'..."
   o=$(sudo curl -sSfL https://bootstrap.pypa.io/pip/2.7/get-pip.py | python 2>&1)
   r=$?
   print_result_or_die "$o" $r
}

install_homebrew
install_pip2

# Installation of MacOS specific packages should happen below.
# install_package 'vim' true


