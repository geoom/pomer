# pomer

A terminal-based time tracker for tasks, written in Haskell.

## Requirements

- Stack 3.11.1
- GHC 9.10.3 (installed via ghcup)

### macOS-specific requirements

- macOS with Xcode command-line tools
- LLVM 15 (`brew install llvm@15`)

## Install

```bash
make install
# or install to a custom location
make install PREFIX=$HOME/.local/bin
```

## Quick Start

Run from source:

```bash
stack --system-ghc runghc -- Main.hs
```

Or run the installed executable:

```bash
pomer
```

## License

TBD
