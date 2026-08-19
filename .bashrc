# ~/.bashrc: executed by bash(1) for non-login shells.

# This is Chris Young's .bashrc.  Almost everything here is ripped off
# from somewhere else.  It is shared between machines, so it must stay
# compatible with the bash macOS ships (3.2) and must not assume a Mac.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

########################################
# Homebrew
########################################

# Apple silicon keeps brew in /opt/homebrew, Intel in /usr/local, and a
# Linux box may not have it at all.
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [ -x "$_brew" ]; then
        eval "$("$_brew" shellenv)"
        break
    fi
done
unset _brew

########################################
# History
########################################

HISTFILESIZE=100000000
HISTSIZE=100000
HISTTIMEFORMAT="%F %T " # for e.g. "1999-02-29 23:59:59"

# Not everything in history is interesting
HISTIGNORE="cd:ls:clear:exit"

# don't put duplicate lines or lines starting with a space in the history
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# The next line allows me to share history between different terminals
# Thank you https://spin.atomicobject.com/2016/05/28/log-bash-history/
mkdir -p ~/.logs
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

########################################
# PATH
########################################

# Add a directory to PATH, but only if it exists and is not already there.
path_add() {
    [ -d "$1" ] || return 0
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$PATH:$1" ;;
    esac
}

path_add "$HOME/bin"
path_add "$HOME/.local/bin"
path_add "$HOME/.elan/bin"        # Lean
path_add /Library/TeX/texbin
export PATH

########################################
# Git prompt and completion
########################################

# git ships these itself; where it puts them depends on the platform.
_git_share=""
if [ -z "$_git_share" ] && command -v xcode-select >/dev/null 2>&1; then
    _git_share="$(xcode-select -p 2>/dev/null)/usr/share/git-core"
fi

for _f in \
    "$_git_share/git-prompt.sh" \
    /usr/share/git-core/contrib/completion/git-prompt.sh \
    "$(brew --prefix 2>/dev/null)/etc/bash_completion.d/git-prompt.sh"
do
    if [ -r "$_f" ]; then . "$_f"; break; fi
done

for _f in \
    "$_git_share/git-completion.bash" \
    /usr/share/bash-completion/completions/git \
    "$(brew --prefix 2>/dev/null)/etc/bash_completion.d/git-completion.bash"
do
    if [ -r "$_f" ]; then . "$_f"; break; fi
done
unset _f _git_share

# Keep PS1 working even where git-prompt.sh was not found.
type __git_ps1 >/dev/null 2>&1 || __git_ps1() { :; }

# What the prompt marks after the branch name:
#   *  unstaged changes        +  staged changes
#   %  untracked files         $  something stashed
#   <  behind upstream         >  ahead        <> diverged   = in sync
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"

green=$(tput setaf 2)
blue=$(tput setaf 4)
reset=$(tput sgr0)
bold=$(tput bold)

PS1='\[$blue$bold\]\w\[$reset\]\[$green$bold\]$(__git_ps1 " (%s)")\[$reset\]\$ '

########################################
# Colours
########################################

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

########################################
# Aliases and functions
########################################

source ~/.aliases
source ~/.functions

########################################
# Python
########################################

# Prevent pip from installing into system Python . . .
export PIP_REQUIRE_VIRTUALENV=true
# but make it possible to override this if necessary
gpip() {
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

########################################
# Completion
########################################

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring
# wildcards.  Many thanks:
# https://raw.github.com/mathiasbynens/dotfiles/master/.bash_profile
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" \
    -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" \
    scp sftp ssh

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

########################################
# tmux
########################################

if [ -n "$TMUX" ]; then
    TMOUT=0
fi

########################################
# Work
########################################

# Everything above is shared.  The work machine has no ~/.personal_machine
# and picks up its extras here.  Note the $HOME: testing a bare
# ".personal_machine" checked the *current directory*, so any shell not
# started in $HOME sourced the work config on the personal machine.
if [ ! -f "$HOME/.personal_machine" ] && [ -r ~/code/dotfiles/schrodinger.sh ]; then
    source ~/code/dotfiles/schrodinger.sh
fi
