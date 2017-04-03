#!/bin/bash

set -e

export PATH=$PATH:/go/src/github.com/uber/go-torch/FlameGraph
cat > $HOME/.bashrc <<- 'EOF'
function color_my_prompt {
    local __user_and_host="\[\033[01;32m\]\u"
    local __cur_location="\[\033[01;34m\]\w"
    local __git_branch_color="\[\033[31m\]"
    #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    export PS1="$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}
color_my_prompt
export GOPATH=/go
export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH
EOF

cat > $HOME/.profile <<- 'EOF'
source ~/.bashrc
EOF

cat > $HOME/.vimrc <<- EOF
syntax on
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
EOF

cat > $HOME/.screenrc <<- EOF
shell "/bin/bash"
escape ^Bb
EOF

cat > $HOME/.gitconfig <<- EOF
[color]
  diff = auto
  status = auto
  branch = auto
  interactive = auto
  ui = true
  pager = true
EOF

cp /root/ssh/* /root/.ssh
chmod -R 0600 /root/.ssh

"$@"
