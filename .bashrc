# .bashrc

# Source global definitions
#if [ -f /etc/bashrc ]; then
	#. /etc/bashrc
#fi

#if [ -f /usr/share/doc/git2u-core-doc-2.16.4/contrib/completion/git-completion.bash ]; then
#. /usr/share/doc/git2u-core-doc-2.16.4/contrib/completion/git-completion.bash
#fi

if [ -f /etc/profile.d/bash_completion.sh ]; then
    source /etc/profile.d/bash_completion.sh
fi


alias git='/usr/bin/git'
alias vi='/usr/local/bin/vim'
alias ls='ls --color=auto'
#alias vs='/usr/local/bin/vim -S .session'
#alias gdb='/usr/local/bin/cgdb'
alias python='/usr/local/bin/python2.7'
alias python3='python3.4'
alias z='/usr/local/bin/zdict'
#alias python2='/usr/local/bin/python2.7'
TERM=xterm-256color
#alias cgdb='TERM=screen-256color cgdb'
# User specific aliases and functions

source /opt/devtool7.rc

#LANG=en_US.utf8
LANG=zh_TW.UTF-8
#PS1='\[\e[32m\]\u@\h\[\e[m\]\[\e[36m\]: \w\$\[\e[m\] '
PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[00m\]\$ '
#PS1='\e[01;32m\]\u@\h\e[00m\]: \e[01;34m\]\w\e[00m\]\$ '
#PS1="\[$(printf "\x1b[48;2;15;100;50m\]A nice dark green [rgb(15,100,50)]:\[\x1b[0m")\] "

export VISUAL=vim
export CXX="distcc /opt/rh/devtoolset-7/root/usr/bin/g++"
export CC="distcc /opt/rh/devtoolset-7/root/usr/bin/gcc"
unset MAILCHECK

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
