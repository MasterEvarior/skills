# Skills

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

A collection of [Claude Code](https://claude.com/claude-code) skills, packaged and built as [Nix](https://nixos.org/) flake outputs. Each skill lives in its own directory under `skills/` and consists of a `SKILL.md` describing what the skill does, together with any supporting assets and reference material.

## Build

Each skill is exposed as a package of the flake. To build a specific skill:

```shell
nix build .#<skill-name>
```

For example:

```shell
nix build .#create-readme
```

The result is a directory containing the skill's `SKILL.md` and its `assets`/`references` subdirectories, ready to be picked up by Claude Code.

## Run

These packages are not standalone executables. Instead, the built output of a skill (its `SKILL.md`, `assets` and `references`) is meant to be made available to Claude Code, for example by linking the build result into Claude's skills directory.

## Development

### Adding a new skill

1. Create a new directory under `skills/`, e.g. `skills/my-skill`, with at least a `SKILL.md` file.
1. Add an entry for it to `skills/skills.nix`, pointing `src` at the new directory and providing a short `description`.

### Formatting

All formatting is run through the flake's formatter (Markdown is formatted with `mdformat`):

```shell
nix fmt
```

### Git Hooks

There are hooks that enforce [Conventional Commits](https://www.conventionalcommits.org/)-style commit messages. To use them, run:

```shell
git config --local core.hooksPath .githooks/
```

## Improvements, Issues and More

Pull requests, improvements and issues are always welcome.

## Credits

- The [grill-me skill](./skills/grill-me/SKILL.md) was copied from [mattpocock](https://github.com/mattpocock/skills/blob/main/skills/productivity/grilling/SKILL.md)