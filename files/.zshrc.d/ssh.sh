function xssh {
   ssh -C -R6000:localhost:6000 $*
}
