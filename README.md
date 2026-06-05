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

## Command and data contract

The persistence and reporting commands below are the agreed contract for upcoming
milestones; the current release only runs the foreground timer.

### Commands

```text
pomer                              # start an unlabeled session
pomer write proposal               # start a session labeled "write proposal"
pomer report today                 # report the current local day
pomer report week                  # report the current local week
pomer report --from 2026-09-01 --to 2026-10-01
pomer history                      # list recent sessions
pomer --help                       # show help without starting a session
pomer -- report                    # start a session literally labeled "report"
pomer -- --help                    # start a session literally labeled "--help"
```

`report` and `history` are reserved when they are the first argument, and all
flags are reserved. `--` ends command and flag parsing; every following word is
the task label. This intentionally changes the current behavior for labels whose
first word is reserved or starts with `-`. Other task labels, including
multiword labels, retain their meaning, and no arguments still start an
unlabeled session. Invalid commands, arguments, and unescaped flags must fail
with usage rather than start a timer.

The report range includes `--from` and excludes `--to`. A week starts on Monday.
Reports use the machine's current local time zone when the report runs and split
a session at local-day boundaries, including daylight-saving boundaries.

### Saved sessions

A session has a stable ID, an optional label, start and end timestamps, recorded
duration, and a state of `completed` or `interrupted`. Ctrl+C finalizes and saves
a completed session. On abnormal termination, recovery saves only duration that
was durably checkpointed before termination, marks the session interrupted, and
never infers time after the last checkpoint. The checkpoint interval and its
maximum possible lost-time window will be fixed and documented with persistence.

Sessions will be stored in a versioned JSON document at:

```text
$POMER_DATA_DIR/sessions.json                  # when POMER_DATA_DIR is set
$XDG_DATA_HOME/pomer/sessions.json             # otherwise, when XDG_DATA_HOME is set
$HOME/.local/share/pomer/sessions.json         # fallback
```

Writers must hold a separate exclusive process lock. A second foreground timer
is rejected clearly. Updates write and sync a temporary file before atomically
replacing `sessions.json`; incompatible or malformed data must fail without
replacing the original. Tests must always set `POMER_DATA_DIR` to an isolated
temporary directory and never use the user's real store.

## License

TBD
