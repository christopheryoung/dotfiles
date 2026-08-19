#!/bin/bash
################################################################################
# First-run setup for a Mac. Safe to re-run: every step checks whether it
# has already been done.
#
#     ./osx_setup.sh --dry-run     show what would happen, change nothing
#     ./osx_setup.sh               do it
#     ./osx_setup.sh --with-locate also enable the locate database (sudo)
#
# Run ./setup.sh first, to put the dotfiles in place.
#
# Manual installs this does not attempt:
#   Emacs   https://emacsformacosx.com
#   Skim    https://skim-app.sourceforge.io
#   XQuartz https://www.xquartz.org
################################################################################

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=false
WITH_LOCATE=false

for arg in "$@"; do
    case "$arg" in
        --dry-run)     DRY_RUN=true ;;
        --with-locate) WITH_LOCATE=true ;;
        *) echo "unknown option: $arg" >&2; exit 1 ;;
    esac
done

say()  { echo; echo "==> $*"; }
skip() { echo "    already done: $*"; }
run() {
    if $DRY_RUN; then
        echo "    would run: $*"
    else
        echo "    $*"
        "$@"
    fi
}

$DRY_RUN && echo "DRY RUN -- nothing will be changed."

########################################
# Xcode command line tools
########################################

say "Xcode command line tools"
if xcode-select -p >/dev/null 2>&1; then
    skip "$(xcode-select -p)"
else
    echo "    this opens a GUI installer; re-run this script once it finishes"
    run xcode-select --install
fi

########################################
# Homebrew
########################################

say "Homebrew"
if command -v brew >/dev/null 2>&1; then
    skip "$(brew --prefix)"
else
    echo "    installing Homebrew; it will ask for your password"
    run /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # A fresh install is not on PATH until the shell picks it up.
    for p in /opt/homebrew/bin/brew /usr/local/bin/brew; do
        [ -x "$p" ] && eval "$("$p" shellenv)" && break
    done
fi

########################################
# Packages
########################################

say "Packages"
if command -v brew >/dev/null 2>&1; then
    # A failed update (a stale tap, no network) should not stop the rest.
    if $DRY_RUN; then
        echo "    would run: brew update"
    else
        brew update || echo "    brew update failed; continuing"
    fi
    # --no-upgrade installs what is missing without upgrading everything
    # else, which otherwise pulls in things like a multi-gigabyte MacTeX
    # refresh on every run.
    run brew bundle install --file="$DOTFILES/Brewfile" --no-upgrade

    if [ -f "$HOME/.personal_machine" ]; then
        run brew bundle install --file="$DOTFILES/Brewfile.personal" --no-upgrade
    else
        echo "    skipping Brewfile.personal (no ~/.personal_machine)"
    fi
else
    echo "    no brew on PATH; skipping"
fi

########################################
# fzf shell integration
########################################

say "fzf shell integration"
if [ -f "$HOME/.fzf.bash" ]; then
    skip "~/.fzf.bash"
elif command -v brew >/dev/null 2>&1 && [ -x "$(brew --prefix)/opt/fzf/install" ]; then
    # --no-update-rc because .bashrc already sources ~/.fzf.bash itself
    run "$(brew --prefix)/opt/fzf/install" --all --no-update-rc
else
    echo "    fzf not installed; skipping"
fi

########################################
# Emacs packages
########################################

say "Emacs packages"
EMACS=""
for candidate in /Applications/Emacs.app/Contents/MacOS/Emacs "$(command -v emacs || true)"; do
    [ -n "$candidate" ] && [ -x "$candidate" ] && EMACS="$candidate" && break
done

if [ -z "$EMACS" ]; then
    echo "    Emacs not found; install it, then run:"
    echo "      emacs --batch -l ~/.emacs.d/bootstrap-packages.el"
elif [ -d "$HOME/.emacs.d/straight/build" ]; then
    skip "straight packages present (see README to update them)"
else
    echo "    installing packages and pinning them to the lockfile"
    run "$EMACS" --batch -l "$DOTFILES/emacs.d/bootstrap-packages.el"
fi

########################################
# locate database (opt in: needs sudo, touches a system daemon)
########################################

say "locate database"
if ! $WITH_LOCATE; then
    echo "    skipped; pass --with-locate to enable it (needs sudo)"
elif sudo launchctl list com.apple.locate >/dev/null 2>&1; then
    skip "com.apple.locate is loaded"
else
    run sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist
    run sudo /usr/libexec/locate.updatedb
fi

########################################

say "Done"
if command -v brew >/dev/null 2>&1 && ! $DRY_RUN; then
    n="$(brew outdated --quiet | wc -l | tr -d ' ')"
    if [ "$n" -gt 0 ]; then
        echo "    $n outdated brew packages; 'brew outdated' to list,"
        echo "    'brew upgrade' to update them"
    fi
fi
echo "    tmux plugins, if wanted:"
echo "      git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"
