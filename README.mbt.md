# wt

Native MoonBit implementation of the `wt` Git worktree manager for inspecting and safely cleaning up worktrees with GitHub pull-request awareness.

This module contains the installable `wt` executable. The detailed package README, including the complete command reference, is [available in `src/README.mbt.md`](./src/README.mbt.md).

## Usage

List worktrees from the current repository:

```console
$ wt ls
NAME BRANCH PR GIT PATH
main main main pushed /path/to/repository
feature feature OPEN(#42) committed /path/to/feature
```

Preview eligible cleanup without changing files:

```console
$ wt cleanup --dry-run
[dry-run] Would remove: /path/to/feature (feature, merged (pushed))
Done: 1 removed, 0 skipped (dry-run)
```

## Key features

- Lists each Git worktree with its branch, pull-request state, Git state, and path.
- Detects open, merged, closed, absent, and unknown pull-request states through the GitHub CLI.
- Removes only non-main worktrees whose branches are pushed and whose pull request is merged, closed, or absent.
- Supports a dry-run mode for inspecting cleanup candidates without changing files.

## Prerequisites

- **Git**: Required for worktree discovery, status inspection, and cleanup.
- **GitHub CLI (`gh`)**: Required for pull-request state lookup; without it, pull-request state may be reported as `unknown`.
- **Nix**: Required for the documented package installation path.

## Setup

1. Install the native package with Nix.

```bash
nix profile install github:totto2727-org/wt
```

2. Verify the installation.

```bash
wt --version
```

## API

The module exposes the `wt` executable with `ls` and `cleanup` commands. See the [package API reference](./src/README.mbt.md#api) for command arguments, options, output fields, and cleanup rules.

```console
$ wt --help
```

## Development

For repository structure, development commands, architecture, and contribution rules, see [AGENTS.md](./AGENTS.md).

## License

MIT; see [LICENSE](./LICENSE).

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
