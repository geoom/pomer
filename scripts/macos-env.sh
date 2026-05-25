#!/usr/bin/env bash
# macOS-specific environment setup for the pomer Haskell project.
# Source this file before running any Stack/GHC commands on macOS:
#   source scripts/macos-env.sh

SDK=$(xcrun --show-sdk-path)
export SDKROOT="$SDK"
export CPATH="$SDK/usr/include"
export CPLUS_INCLUDE_PATH="$SDK/usr/include/c++/v1:$SDK/usr/include"
export LIBRARY_PATH="$SDK/usr/lib"
export PATH="$HOME/.ghcup/ghc/9.10.3/bin:/usr/local/opt/llvm@15/bin:$PATH"
