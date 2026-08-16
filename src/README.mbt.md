# wt

Native MoonBit implementation of the `wt` Git worktree manager for developers who want to inspect and safely clean up Git worktrees with GitHub pull-request awareness.

This is the package-local canonical literate README. The module-level overview is [available at the repository root](../README.mbt.md).

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

Run `wt --help` for the top-level command list, or `wt <command> --help` for command-specific options.

## Key features

- Lists each Git worktree with its branch, pull-request state, Git state, and path.
- Detects open, merged, closed, absent, and unknown pull-request states through the GitHub CLI.
- Removes only non-main worktrees whose branches are pushed and whose pull request is merged, closed, or absent.
- Supports a dry-run mode for inspecting cleanup candidates without changing files.

## Prerequisites

- **Git**: Required for worktree discovery, status inspection, and cleanup.
- **GitHub CLI (`gh`)**: Required for pull-request state lookup; without it, pull-request state may be reported as `unknown`.
- **GitHub remote**: The repository must have an `origin` remote using an `https://github.com/...` or `git@github.com:...` URL for pull-request lookups.

## Setup

1. Install the native package with Nix.

```bash
nix profile install github:totto2727-org/wt
```

2. Verify the installation.

```bash
wt --version
```

3. Authenticate the GitHub CLI when pull-request state is needed.

```bash
gh auth login
```

## API

### `wt`

Runs the worktree manager. The global `--help` (`-h`) option prints usage and commands, and `--version` (`-V`) prints the installed version.

```console
$ wt --help
```

### `wt help`

Prints help for the top-level command or a subcommand.

```console
$ wt help cleanup
```

### `wt ls [dir]`

Lists worktrees for the Git repository at `dir`, or for the current directory when `dir` is omitted. Each row contains `NAME`, `BRANCH`, `PR`, `GIT`, and `PATH`. `PR` is `main`, `none`, `OPEN(#N)`, `MERGED(#N)`, `CLOSED(#N)`, or `unknown`; `GIT` is `dirty`, `committed`, or `pushed`.

```console
$ wt ls /path/to/repository
```

### `wt cleanup [dir] [--dry-run|-n]`

Examines non-main worktrees for the repository at `dir`, or the current directory when `dir` is omitted. A worktree is eligible only when its branch is pushed and its pull request is merged, closed, or absent. Without `--dry-run`, eligible worktrees and their local branches are removed and Git worktree metadata is pruned. With `--dry-run` (or `-n`), removals are printed but no files or branches are changed.

```console
$ wt cleanup --dry-run /path/to/repository
$ wt cleanup -n
```

```mbt check
///|
test "README MoonBit validation is executable" {
  inspect(40 + 2, content="42")
}
```

## Development

For repository structure, development commands, architecture, and contribution rules, see [AGENTS.md](../AGENTS.md).

## License

MIT; see [LICENSE](../LICENSE).

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
