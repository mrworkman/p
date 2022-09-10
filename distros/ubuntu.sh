
function install_pip3 {
   [[ -e /usr/local/bin/pip3 ]] && return

   # NB: WSL2 does not currently support IPv6, so curl must explicitly use `-4`.

   printf "Installing pip for python3..."
   o=$(sudo curl -s4 https://bootstrap.pypa.io/get-pip.py | sudo python3 2>&1 > /dev/null)
   r=$?
   print_result_or_die "$o" $r
}

function clean_up {
   sudo apt-get -y autoremove > /dev/null
}

# Installation of Ubuntu specific packages should happen below.
install_package 'nano' false

if [[ ! $wsl ]]; then
   install_package 'coreutils'      true
   install_package 'zsh'            true
   install_package 'vim-nox'        true
   install_package 'git'            true
   install_package 'unity'          true
   install_package 'gnome-terminal' true
   install_package 'openssh-server' true
   install_package 'firefox'        true
   install_package 'gtk-chtheme'    true
else
   install_package 'coreutils'      true
   install_package 'zsh'            true
   install_package 'vim-nox'        true
   install_package 'git'            true
   install_package 'unity'          false
   install_package 'gnome-terminal' false
   install_package 'openssh-server' false
   install_package 'firefox'        false
   install_package 'gtk-chtheme'    false
fi

install_package 'python3'           true
install_package 'python3-venv'      true
install_package 'python3-distutils' true
install_pip3

install_package 'gcc'               true
install_package 'make'              true
install_package 'automake'          true

install_package 'libreoffice'       false
install_package 'xdg-utils'         true  # needed for tmux

clean_up -y
