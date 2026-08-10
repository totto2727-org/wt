# wt

Native MoonBit implementation of the `wt` Git worktree manager.

## Usage

```bash
wt ls [directory]
wt cleanup [directory] --dry-run
```

`ls` shows each worktree's branch, pull request state, Git state, and path. `cleanup` removes non-main worktrees only when their branch is pushed and its pull request is merged, closed, or absent. Use `--dry-run` to inspect eligible removals without changing the repository.

## Development

Enter the Nix development shell, then run the repository tasks:

```bash
nix develop
moon check
moon test
moon package --list
```

Build the installable package with `nix build .#wt`.
