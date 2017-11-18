# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f /usr/share/doc/git2u-core-doc-2.14.2/contrib/completion/git-completion.bash ]; then
. /usr/share/doc/git2u-core-doc-2.14.2/contrib/completion/git-completion.bash
fi

alias git='/usr/bin/git'
alias vi='/usr/local/bin/vim'
alias vs='/usr/local/bin/vim -S .session'
alias gdb='/usr/local/bin/cgdb'
alias python='/usr/local/bin/python2.7'
alias gdb='/usr/local/bin/cgdb'
alias z='/usr/local/bin/zdict'
#alias python2='/usr/local/bin/python2.7'
TERM=xterm-256color
# User specific aliases and functions

source /opt/devtool6.rc

#LANG=en_US.utf8
LANG=zh_TW.UTF-8
#PS1='\[\e[32m\]\u@\h\[\e[0m\]\[\e[36m\]:\w\$\[\e[0m\] '
PS1='\e[01;32m\]\u@\h\e[00m\]: \e[01;34m\]\w\e[00m\]\$ '

export CXX="distcc /opt/rh/devtoolset-6/root/usr/bin/g++"
export CC="distcc /opt/rh/devtoolset-6/root/usr/bin/gcc"
unset MAILCHECK
