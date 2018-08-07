#
# Cookbook:: p
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# include_recipe "on_failure::default"
# include_recipe "poise-python"

platform_family = node['platform_family']

# Check if the OS is Windows Subsystem for Linux (WSL)
is_wsl = node['os'] == 'linux' && node['kernel']['release'].end_with?('Microsoft')

packages=[
   { :name => 'git',            :sys => true, :wsl => true  },
   { :name => 'vim-nox',        :sys => true, :wsl => true  },
   { :name => 'unity',          :sys => true, :wsl => true  },
   { :name => 'gnome-terminal', :sys => true, :wsl => true  },
   { :name => 'gtk-chtheme',    :sys => true, :wsl => true  },
   { :name => 'zsh',            :sys => true, :wsl => true  },
   { :name => 'tmux',           :sys => true, :wsl => true  },
   { :name => 'python',         :sys => true, :wsl => true  },
   { :name => 'python-pip',     :sys => true, :wsl => true  },
   { :name => 'python3.6',      :sys => true, :wsl => true  },
   { :name => 'python3.6-venv', :sys => true, :wsl => true  },
   { :name => 'gcc',            :sys => true, :wsl => true  },
   { :name => 'make',           :sys => true, :wsl => true  },
   { :name => 'automake',       :sys => true, :wsl => true  },
   { :name => 'xrdp',           :sys => true, :wsl => false },
   { :name => 'xorgxrdp',       :sys => true, :wsl => false },
   { :name => 'openssh-server', :sys => true, :wsl => false },

   { :name => 'nano',           :sys => false, :wsl => false },
   { :name => 'libreoffice',    :sys => false, :wsl => false },
   { :name => 'firefox',        :sys => true,  :wsl => false },
]

user = ENV['USER']
sudo_user = ENV['SUDO_USER']

if user == 'root'
   if !sudo_user.nil? && !sudo_user.empty?
      user = sudo_user
   end
end

pip_binary = '/usr/local/bin/pip3.6'

apt_repository 'deadsnakes-python' do
   uri 'ppa:deadsnakes/ppa'
end

apt_update
# apt_update 'update' do
#    action :update
# end

packages.each do |package|

   if is_wsl
      apt_package package[:name] do
         action package[:wsl] ? :install : :purge
      end
   else
      apt_package package[:name] do
         action package[:sys] ? :install : :purge
      end
   end

end

apt_package 'python3-distutils'

# Install PIP for Python 3.6
execute 'install-pip36' do
   command <<-EOF
      curl -s https://bootstrap.pypa.io/get-pip.py | python3.6
   EOF
   not_if { File.exists? pip_binary }
end


# Set the default editor for invoking user, and for root
file "/home/#{user}/.selected_editor" do
   content 'SELECTED_EDITOR="/usr/bin/vim.nox"\n'
   owner   user
   group   user
   mode    '0644'
   action :create

   not_if { user == 'root' }
end

file '/root/.selected_editor' do
   content 'SELECTED_EDITOR="/usr/bin/vim.nox"\n'
   owner   'root'
   group   'root'
   mode    '0644'
   action :create
end

[
   "/home/#{user}/.local", 
   "/home/#{user}/.local/share", 
   "/home/#{user}/.local/share/fonts",
   "/home/#{user}/.vim",
   "/home/#{user}/.vim/colors",
   "/home/#{user}/.tmux",
   "/home/#{user}/.tmux/plugins",
   "/home/#{user}/.tmux/plugins/maglev"
].each do |dir|
   directory dir do
      owner user
      group user
      mode '0755'
      action :create
   end
end

remote_directory "/home/#{user}/.local/share/fonts/NerdFonts" do
   source 'NerdFonts'
   files_owner  user
   files_group  user
   files_mode  '0644'

   owner  user
   group  user
   mode  '0755'
   action :create
end

remote_directory "/home/#{user}/.local/share/fonts/Fira" do
   source 'Fira'
   files_owner  user
   files_group  user
   files_mode  '0644'

   owner  user
   group  user
   mode  '0755'
   action :create
end

execute 'update font cache' do
   user  user
   group user
   command "fc-cache"
end

cookbook_file "/etc/vim/vimrc.local" do
   source 'vimrc.local'
   mode   '0644'
   action :create
end

cookbook_file "/home/#{user}/.vimrc" do
   source 'vimrc'
   owner   user
   group   user
   mode   '0644'
   action :create
end

remote_file "/home/#{user}/.vim/colors/PaperColor.vim" do
   source 'https://raw.githubusercontent.com/NLKNguyen/papercolor-theme/master/colors/PaperColor.vim'
   owner   user
   group   user
   mode   '0644'
   action :create
  
   on_failure {
      notify :create, "cookbook_file[/home/#{user}/.vim/colors/PaperColor.vim]"
   }
end

cookbook_file "/home/#{user}/.vim/colors/PaperColor.vim" do
   source 'PaperColor.vim'
   owner   user
   group   user
   mode   '0644'
   action :nothing
end

# Install Python Modules
python_package 'powerline-status'

directory "/home/#{user}/.oh-my-zsh" do
   recursive true
   action :delete
end

execute 'install-oh-my-zsh' do
   user  user
   group user
   command <<-EOF
      export SHELL=/usr/bin/zsh; curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed -n '/env zsh/!p' | sh
   EOF
end

remote_file "/home/#{user}/.oh-my-zsh/themes/bullet-train.zsh-theme" do
   source 'https://raw.githubusercontent.com/caiogondim/bullet-train.zsh/master/bullet-train.zsh-theme'
   owner   user
   group   user
   mode   '0644'
   action :create
  
   on_failure {
      notify :create, "cookbook_file[/home/#{user}/.oh-my-zsh/themes/bullet-train.zsh-theme]"
   }
end

cookbook_file "/home/#{user}/.oh-my-zsh/themes/bullet-train.zsh-theme" do
   source 'bullet-train.zsh-theme'
   owner   user
   group   user
   mode   '0644'
   action :nothing
end

cookbook_file "/home/#{user}/.zshrc" do
   source 'zshrc'
   owner   user
   group   user
   mode   '0644'
   action :create
end

cookbook_file "/home/#{user}/.tmux.conf" do
   source 'tmux.conf'
   owner   user
   group   user
   mode   '0644'
   action :create
end

ruby 'update-bashrc' do
   user  user
   group user
   interpreter 'bash'
   code <<-EOH
      grep 'export DISPLAY=' $HOME/.bashrc > /dev/null 2>&1
      if [[ $? != 0 ]]; then
         printf "\nexport DISPLAY=:0.0\n" >> $HOME/.bashrc
      fi
   EOH
end

git 'install-tmux-tpm' do
   repository  'https://github.com/tmux-plugins/tpm.git'
   revision    'master'
   destination "/home/#{user}/.tmux/plugins/tpm"
   user        user
   group       user
   action      :checkout

   not_if { File.exists? "/home/#{user}/.tmux/plugins/tpm" }
end

execute 'install-tpm-plugins' do
   user  user
   group user
   command <<-EOF
      /home/#{user}/.tmux/plugins/tpm/bin/install_plugins
   EOF
end

# Overwrite the maglev config with a customized one
cookbook_file "/home/#{user}/.tmux/plugins/maglev/maglev.tmux" do
   source 'maglev.tmux'
   owner   user
   group   user
   mode   '0744'
   action :create
end

cookbook_file "/home/#{user}/.gitconfig" do
   source 'gitconfig'
   owner   user
   group   user
   mode   '0644'
   action :create
end

#
# Generate new SSH keys (if they don't already exist)
execute 'generate-local-ssh-key' do
   user  user
   group user
   command <<-EOF
      ssh-keygen -t rsa -b 8192 -f $HOME/.ssh/id_rsa -N ''
   EOF

   not_if { File.exists? "/home/#{user}/.ssh/id_rsa" }
end

execute 'generate-github-key' do
   user  user
   group user
   command <<-EOF
      ssh-keygen -t rsa -b 8192 -f $HOME/.ssh/id_rsa_gh -N ''
   EOF

   not_if { File.exists? "/home/#{user}/.ssh/id_rsa_gh" }
end

cookbook_file "/home/#{user}/.ssh/config" do
   source 'ssh-config'
   owner   user
   group   user
   mode   '0600'
   action :create_if_missing
end

cookbook_file "/home/#{user}/.fonts.conf" do
   source 'fonts.conf'
   owner   user
   group   user
   mode   '0644'
   action :create
end

cookbook_file "/tmp/gnome-terminal-profile.dconf" do
   source 'gnome-terminal-profile.dconf'
   owner   user
   group   user
   mode   '0644'
   action :create
end

# Setting user/group on this one's not sufficient. Need to run
# as a login session in order for dconf to connect.
execute 'change-gnome-terminal-settings' do
   command <<-EOF
      su -l -c "DISPLAY=:0.0 dconf load /org/gnome/terminal/legacy/ < /tmp/gnome-terminal-profile.dconf" #{user}
   EOF
end
