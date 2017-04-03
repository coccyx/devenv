My docker based development environment.  Works well for Go and Nodejs development, and it has tools for doing C/C++ development I just haven't done much in a while.

To use, run `run.sh` from any directory you want to develop in.  It will mount that directory in `/<dirname>`.  If your directory is in $HOME/go it will be smart enough to mount this in `/go/src/<path>/<to>/<dirname>`.  
