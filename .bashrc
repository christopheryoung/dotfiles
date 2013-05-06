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

##Colors for a mac

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Alias definitions.
source ~/.aliases

# Fiddle with path

export PATH=$PATH:$HOME/bin
export PATH=$PATH:/usr/local/bin

if [[ $OSTYPE == darwin* ]]; then
    export PATH=$PATH:/usr/local/share/npm/bin
    export PATH=$PATH:$HOME/Library/Haskell/bin
    export PATH=$PATH:/Library/Haskell/bin
    export PATH=$PATH:/Applications/Postgres.app/Contents/MacOS/bin
    export PATH=$PATH:$HOME/Applications/adt-bundle-mac/sdk/platform-tools
    export PATH=$PATH:$HOM/Applications/adt-bundle-mac/sdk/tools
fi

if [[ $OSTYPE == linux* ]]; then
    export PATH=$PATH:$HOME/.cabal/bin
fi

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

# z.sh for jumping around
. ~/code/dotfiles/scripts/z.sh
