#!/bin/bash

# Script to install system-wide extra goodies after haskell is downloaded and installed

cabal update
cabal install cabal-install

cabal install hsenv

cabal install hoogle
hoogle data

cabal install ghc-mod

cabal install lambdabot
cabal install goa
