# Package manifest for a new Mac. Apply with:
#
#     brew bundle --file=Brewfile
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
brew "git"                # newer than Apple's, and ships completions
brew "git-delta"          # syntax-highlighted diffs; see gitconfig to enable
brew "lazygit"            # terminal UI for status/staging/history

# Writing and research
brew "aspell"
brew "bib-tool"
brew "imagemagick"
brew "monolith"           # single-file web page capture, used by capture-website
brew "pandoc"             # --citeproc is built in; pandoc-citeproc is gone
brew "xpdf"

# Development
brew "cloc"
brew "pkg-config"
brew "ruff"               # Python linter and formatter, also used by Emacs
brew "uv"                 # Python packaging and script runner
                          # (currently installed standalone in ~/.local/bin;
                          #  brew's copy would take precedence on PATH)
brew "node"
