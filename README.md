# Skills

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

A collection of LLM skills, packaged and built as [Nix](https://nixos.org/) flake outputs. Each skill lives in its own directory under `skills/` and consists of a `SKILL.md` describing what the skill does, together with any supporting assets and reference material.

Some would say it is not practical to use Nix packages for that, others would say it is unethical to use LLMs. I just want to write some Nix code.

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

These packages are not standalone executables. Instead, the built output of a skill is basically just a directory following [an established convention](https://agentskills.io/home). You can use these by linking it into the correct directory for your LLM agent to use.

## Development

### Adding a new skill

1. Create a new directory under `skills/`, e.g. `skills/my-skill`, with at least a `SKILL.md` file.
1. Add an entry for it to `skills/skills.nix`, pointing `src` at the new directory and providing a short `description`.

### Adding a skill from a Git repository

It is possible to fetch skills from other git repositories:

```nix
{
  src = fetchHelpers.fetchFromGitSrc {
    name = "docling";
    url = "https://github.com/docling-project/docling";
    rev = "3181d9fcbb8b7568ceba14b7ed5cd21f66b221e7";
    rootDir = "docling/.agents/skills/docling";
    hash = "sha256-1Vb/dG/bYvZ8l+4meDNqjGSYqpP0B4iqHNbLxwtYli4=";
  };
  description = "...";
}
```

### Formatting

All formatting is run through the flake's formatter:

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
