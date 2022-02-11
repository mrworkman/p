if [[ -e /etc/wsl.conf ]]; then
   alias wgit='/mnt/c/Program\ Files/Git/bin/git.exe'

   function git {
      local rwd="$(realpath "$(pwd)")"

      case $rwd in
         /mnt/c/*)
            ;&
         /mnt/d/*)
            wgit "$@"
            ;;
         *)
            command git "$@"
            ;;
      esac
   }

   function gradlew {
      local cmd='/mnt/c/WINDOWS/system32/cmd.exe'
      local rwd="$(realpath "$(pwd)")"

      case $rwd in
         /mnt/c/*)
            ;&
         /mnt/d/*)
            $cmd /c gradlew.bat "$@"
            ;;
         *)
            if [[ -e $PWD/gradlew ]]; then
               $PWD/gradlew "$@"
            else
               command gradlew "$@"
            fi
            ;;
      esac
   }
fi
