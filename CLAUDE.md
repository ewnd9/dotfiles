# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing configuration files and a custom CLI tool called "belt". The repository uses a yarn workspace monorepo structure with a single package `belt-cli` in the packages directory.

## Architecture

- **Root Level**: Main dotfiles configuration including zshrc, tmux.conf, and various config folders
- **packages/belt-cli**: A Node.js CLI tool that provides custom commands for dotfile management and development tasks
- **config/**: Contains configuration files for various tools (VS Code, iTerm, Karabiner, Obsidian, tmux, zsh)
- **scripts/**: Utility scripts for various system administration tasks
- **snippets/**: Code snippets organized by language

## Key Components

### Belt CLI (`packages/belt-cli/`)
The belt CLI is a command registry system that allows running custom commands with namespacing. Commands are defined in `package.json` under the `belt.commands` section and include:

- `ewnd9:incantation`: Regenerate snippets
- `ewnd9:init`: Initialize project
- `ewnd9:provision`: Provision/sync dotfiles
- `ewnd9:lint-shell`: Lint dotfiles shell scripts
- `repo:open`: Open repository in browser

### Configuration Management
The repository manages configurations for:
- **Shell**: Zsh with custom prompt (Pure), autosuggestions, and git integration
- **Editor**: VS Code settings, keybindings, and snippets
- **Terminal**: iTerm themes and tmux configurations
- **System**: Karabiner keyboard remapping, Obsidian settings

## Common Development Commands

### Linting
```bash
yarn lint              # Lint JavaScript files in packages
yarn lint:shell        # Lint shell scripts using belt CLI
```

### Belt CLI Usage
```bash
belt list              # Show available commands
belt ewnd9:provision   # Sync dotfiles
belt ewnd9:lint-shell  # Lint shell scripts
```

### Setup/Installation
```bash
./init.sh              # Initial setup script
./reload.sh            # Reload configurations
```

## Development Workflow

The repository follows these patterns:
- JavaScript files use ES modules and modern Node.js features
- Shell scripts are located in various directories and linted via belt CLI
- Configuration files are symlinked from this repository to their target locations
- The belt CLI system allows extending functionality through modular commands

## Package Management

- Uses Yarn v4.9.4+ with workspace configuration
- Single workspace package at `packages/belt-cli`
- Global installation of belt CLI for system-wide access
- Dependencies managed at workspace level where appropriate