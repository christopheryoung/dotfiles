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

#Explanation: http://jonisalonen.com/2012/your-bash-prompt-needs-this/
PS1="\[\033[G\]$PS1"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

##Colors for a mac

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Alias definitions.
source ~/.aliases

#I rarely use emacs in a terminal, but for those cases where I do, I
#want to just skip all my customizations
alias emacs='emacs -q'

# Home bin path

export PATH=$PATH:~/bin

# virtualenvwrapper

export WORKON_HOME=~/code/virtualenvs
export PROJECT_HOME=~/code/
source /usr/local/bin/virtualenvwrapper.sh

# Functions
source ~/.functions

# Many thanks: https://raw.github.com/mathiasbynens/dotfiles/master/.bash_profile
# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
source ~/.git-completion.sh

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
