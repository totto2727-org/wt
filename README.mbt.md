# wt

Native MoonBit implementation of the `wt` Git worktree manager for inspecting and safely cleaning up worktrees with GitHub pull-request awareness.

This module contains the installable `wt` executable. The detailed package README, including the complete command reference, is [available in `src/README.mbt.md`](./src/README.mbt.md).

## Usage

List worktrees from the current repository directly from Mooncakes:

```console
$ moonx --target native totto2727/wt ls
NAME BRANCH PR GIT PATH
main main main pushed /path/to/repository
feature feature OPEN(#42) committed /path/to/feature
```

The native target is required because `wt` is a native-only package. See the [package API reference](./src/README.mbt.md#api) for cleanup and installed-command examples.

## Key features

- Lists each Git worktree with its branch, pull-request state, Git state, and path.
- Detects open, merged, closed, absent, and unknown pull-request states through the GitHub CLI.
- Removes only non-main worktrees whose branches are pushed and whose pull request is merged, closed, or absent.
- Supports a dry-run mode for inspecting cleanup candidates without changing files.

## Prerequisites

- **Git**: Required for worktree discovery, status inspection, and cleanup.
- **GitHub CLI (`gh`)**: Required for pull-request state lookup; without it, pull-request state may be reported as `unknown`.
- **GitHub CLI authentication**: Run `gh auth login` when pull-request state is needed.
- **MoonBit or Nix**: Install the MoonBit toolchain for `moonx` and `moon install`, or Nix with flakes enabled for the Nix execution and installation paths.

## Setup

1. Run `wt` directly without installing it.

```bash
moonx --target native totto2727/wt ls
nix run github:totto2727-org/wt -- ls
```

2. Install `wt` with MoonBit or Nix.

```bash
moon install totto2727/wt
nix profile install github:totto2727-org/wt
```

3. Add the `wt` overlay and package to an existing `flake.nix`.

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wt.url = "github:totto2727-org/wt";
  };

  outputs = { nixpkgs, wt, ... }:
    let
      system = "aarch64-darwin"; # Use x86_64-linux on Linux.
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ wt.overlays.default ];
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ pkgs.wt ];
      };
    };
}
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
