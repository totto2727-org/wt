# wt

This file is the canonical developer and AI-agent guide for the native MoonBit `wt` Git worktree manager.

## Repository structure

- `moon.mod` defines the `totto2727/wt` module, its dependencies, native target, package metadata, and root `README.md` entrypoint.
- `README.mbt.md` is the physical module-level overview; root `README.md` is its relative symbolic link.
- `src/moon.pkg` defines the executable package; `src/README.mbt.md` is its detailed canonical user-facing literate README.
- `src/main.mbt` constructs the `wt` CLI with Admiral.
- `src/command_ls.mbt` implements worktree listing and its positional directory argument.
- `src/command_cleanup.mbt` implements safe cleanup, dry-run output, and cleanup eligibility.
- `src/worktree.mbt` discovers Git worktrees, resolves GitHub pull-request state, and computes Git state.
- `src/process_util.mbt` and `src/string_util.mbt` provide process and string helpers used by the CLI.
- `package.nix` defines the installable Nix package; `flake.nix` exposes the package, default package, development shell, and overlay.
- `.github/workflows/` contains MoonBit checks and publishing workflows.
- The root README gives the module overview and links to the detailed package README under `src/`.

## Development commands

### Execution rules

- Run commands from the repository root.
- Enter the Nix development shell with `nix develop` before running MoonBit or package commands.
- Keep `README.mbt.md` as the physical module overview with `README.md -> README.mbt.md`, and keep `src/README.mbt.md` as the package-local canonical README.
- Read the relevant `mbt-coding`, `mbt-test`, and `docs-moonbit` skills before changing MoonBit implementation, tests, or language-specific documentation.
- Run `nix flake update` when intentionally updating pinned flake inputs.

### Standard tasks

- `nix develop` — Enter the pinned development environment.
- `moon check` — Type-check the MoonBit workspace.
- `moon test` — Run the MoonBit tests.
- `moon check README.mbt.md` — Type-check executable MoonBit code blocks in the canonical README.
- `moon check src/README.mbt.md` — Type-check executable MoonBit code blocks in the package README.
- `moon test src/README.mbt.md` — Run executable MoonBit document tests in the package README.
- `moon package --list` — List the package contents used for publication.
- `moon run src -- --help` — Run the CLI and print top-level help.
- `moon run src -- <command> --help` — Run command-specific help, for example `moon run src -- cleanup --help`.
- `nix build .#wt` — Build the installable package.
- `nix run . -- --help` — Run the package's CLI from the flake.

CI runs the shared Nix/MoonBit setup and check actions in `.github/workflows/ci.yml`; publishing workflows run only for pushes to `main`.

## Architecture

### CLI boundary

`src/main.mbt` registers the `ls` and `cleanup` commands with `totto2727/admiral`. Keep user-visible command names, positional arguments, options, and help text synchronized with `src/README.mbt.md`.

### Worktree inspection

`src/worktree.mbt` resolves the repository top-level path, requires a GitHub `origin` remote, parses `git worktree list --porcelain`, and collects pull-request and Git status for each branch. Pull-request queries use `gh pr list`; failed lookups are represented as `unknown` rather than treated as an eligible cleanup state.

### Cleanup safety

`src/command_cleanup.mbt` excludes the main worktree and removes a worktree only when its branch is `pushed` and its pull-request state is `merged`, `closed`, or `none`. Non-dry runs delete the worktree, delete its local branch with `git branch -d`, and then run `git worktree prune`; dry runs must not mutate repository state.

### Packaging

The native MoonBit executable is packaged through `package.nix` and exposed as `wt`, the flake default package, and the `wt` overlay. Keep package metadata in `moon.mod` aligned with the flake package and publication workflows.

## Development tools

- **MoonBit**: Compiles, checks, tests, documents, and runs the native executable.
- **Nix flakes**: Provide the pinned development shell, package, default package, and overlay.
- **Git**: Supplies worktree and repository state to the CLI.
- **GitHub CLI (`gh`)**: Supplies pull-request state for GitHub remotes.
- **Admiral, Lens, and Async**: Provide CLI parsing, JSON access, and asynchronous process/status collection.

## Package-specific rules

- Preserve the MoonBit README layout: root `README.mbt.md` is the physical module overview with `README.md` as its relative symlink, while `src/README.mbt.md` is the detailed package README.
- Keep the README API section complete for the current CLI surface, including global options, command arguments, option aliases, and observable status values.
- Do not add a separate `CLAUDE.md`; this repository uses `AGENTS.md` as its sole agent guide.
- Keep repository-recorded artifacts in English and preserve the existing MIT license and attribution.

_This AGENTS.md was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [AGENTS template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/agents/template.md)._
