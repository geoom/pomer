# pomer

A terminal-based time tracker for tasks, written in Haskell.

## Requirements

- Stack 3.11.1
- GHC 9.10.3 (installed via ghcup)

### macOS-specific requirements

- macOS with Xcode command-line tools
- LLVM 15 (`brew install llvm@15`)

## Install

On macOS, source the environment script before building or running:

```bash
source scripts/macos-env.sh
stack --system-ghc build
stack --system-ghc test
make install
# or install to an existing custom directory
make install PREFIX=$HOME/.local/bin
```

## Quick Start

Run from source:

```bash
make run
make run ARGS='write proposal'
```

Or run the built or installed executable:

```bash
./pomer
pomer "write proposal"
```

Without task words, the timer runs unlabeled. Press Ctrl+C to stop it.

## License

TBD
