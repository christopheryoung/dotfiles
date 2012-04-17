# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# This is Chris Young's .bashrc.  Almost everything here is ripped off from somewhere else.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Expand the history size

HISTFILESIZE=100000000
HISTSIZE=100000

# Not everything in history is interesting

HISTIGNORE="cd:ls:clear:exit"

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

green=$(tput setaf 2)
blue=$(tput setaf 4)
reset=$(tput sgr0)
bold=$(tput bold)
PS1='\[$blue$bold\]\w\[$reset\]\[$green$bold\]$(__git_ps1 " (%s)")\[$reset\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi


# Home bin path

export PATH=$PATH:~/bin

# virtualenvwrapper

export WORKON_HOME=~/code/virtualenvs
export PROJECT_HOME=~/code/
source /usr/local/bin/virtualenvwrapper.sh

#Scheme

alias mit-scheme='/Applications/mit-scheme.app/Contents/Resources/mit-scheme'

# navigate to source for any Python module
# http://chris-lamb.co.uk/2010/04/22/locating-source-any-python-module/
cdp () {
  cd "$(python -c "import os.path as _, ${1}; \
    print _.dirname(_.realpath(${1}.__file__[:-1]))"
  )"
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

#I rarely use emacs in a terminal, but for those cases where I do, I
#want to just skip all my customizations
alias emacs='emacs -q'

# some more ls aliases
alias ll='ls -la --color=auto | less'
alias lm='ls -al |more'    # pipe through 'more'
#alias la='ls -A'
#alias l='ls -CF'

# prevent accidentally clobbering files

#alias rm='rm -i'
alias cp='cp -i'
#alias mv='mv -i'
alias mkdir='mkdir -p'

# make navigation easier

alias ..='cd ..'

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }

# grep expression in all python files in dir and subdirs
function fp() { find . -name '*.py' | xargs grep -n $1;  }

# grep expression in all html files in dir and subdirs
function fh() { find . -name '*.html' | xargs grep -n $1;  }

# colors

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
source ~/.git-completion.sh

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
