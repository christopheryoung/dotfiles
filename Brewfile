# Package manifest for a new Mac. Apply with:
#
#     brew bundle --file=Brewfile
#
# Use --no-upgrade to install what is missing without upgrading
# everything else:
#
#     brew bundle install --file=Brewfile --no-upgrade
#
# brew bundle is idempotent, so re-running it installs only what is
# missing. `brew bundle cleanup --file=Brewfile` lists anything installed
# that is not named here.

# Fonts moved into the main cask repository; homebrew/cask-fonts is gone.
cask "font-hack-nerd-font"
cask "mactex"

# Shell and file tools
brew "bat"                # cat with syntax highlighting
brew "coreutils"
brew "dos2unix"
brew "fd"                 # friendlier find
brew "findutils"
brew "fzf"
brew "ripgrep"
brew "tmux"
brew "tree"
brew "wget"
brew "yank"

# Git
brew "gh"
brew "git-delta"          # syntax-highlighted diffs, wired up in gitconfig

# Writing and research
brew "aspell"
brew "enchant"            # spell-checking library behind Emacs jinx
brew "bib-tool"
brew "imagemagick"
brew "monolith"           # single-file web page capture, used by capture-website
brew "pandoc"             # --citeproc is built in; pandoc-citeproc is gone
brew "poppler"            # pdftotext and friends. Replaces xpdf, which
                          # provides the same binaries and so cannot be
                          # linked alongside it; `brew uninstall xpdf`

# Development
brew "cloc"
brew "pkg-config"
brew "ruff"               # Python linter and formatter, also used by Emacs
brew "uv"                 # Python packaging and script runner
                          # (currently installed standalone in ~/.local/bin;
                          #  brew's copy would take precedence on PATH)
brew "node"
