# dotfiles

Personal development environment for macOS (Apple Silicon) and Arch Linux.
Managed with [GNU Stow](https://www.gnu.org/software/stow/) and [Homebrew](https://brew.sh/).

## Features

- 🚀 **One-command setup** — complete environment in minutes
- 🐚 **Zsh** — modular config (aliases, envs, functions, init)
- 📦 **Resilient package management** — continues even if packages fail
- 🔍 **Health monitoring** — `./install doctor` checks everything
- 🪟 **Tiling WM** — AeroSpace with accordion layout on macOS
- 🔑 **SSH key generation** — automated GitHub setup

## Quick start

```bash
# Clone the repository
git clone https://github.com/MaxHiit/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Full setup
./install init

# Skip SSH key generation
./install init --skip-ssh
```

## Repository structure

```
.dotfiles/
├── install                 # CLI management tool
├── home/                   # dotfiles — stowed to ~/
│   ├── .zshrc              # zsh entry point
│   ├── .config/
│   │   ├── aerospace/      # tiling window manager (macOS)
│   │   ├── ghostty/        # terminal + Gruber Darker theme
│   │   ├── git/            # git config + work config
│   │   ├── mise/           # runtime versions (node, bun, python)
│   │   ├── starship.toml   # prompt
│   │   ├── tmux/           # terminal multiplexer + TPM plugins
│   │   └── zsh/            # aliases, envs, functions, shell, init
│   └── wallpapers/
└── packages/
    └── bundle              # Brewfile — all packages and GUI apps
```

## What's included

**Shell** — zsh with autosuggestions, syntax highlighting, modular config split
across `aliases`, `envs`, `functions`, `shell`, `init`.

**Terminal** — Ghostty with Gruber Darker theme, JetBrainsMono Nerd Font.

**Multiplexer** — tmux with TPM (auto-installed), vim-style navigation,
session persistence via tmux-resurrect and tmux-continuum.

**Git** — delta for diffs, useful aliases, work config loaded conditionally
for `~/Code/work/` repositories.

**Runtimes** — mise manages Node LTS, Bun, Python. uv manages Python packages
and CLI tools.

**Tiling WM** — AeroSpace with accordion layout, 5 workspaces + M (messaging),
monitor assignments for MacBook + external display.

## Daily commands

```bash
# Edit dotfiles in neovim
dotfiles

# Re-create symlinks after adding a new config file
./install stow

# Update packages and pull latest changes
./install update

# Check everything is working
./install doctor

# Retry failed package installations
./install retry

# Generate a new SSH key
./install gen-ssh-key
```

## Adding a package

```bash
# 1. Add to the Brewfile
echo 'brew "package-name"' >> ~/.dotfiles/packages/bundle

# 2. Install it
brew install package-name

# 3. Commit
cd ~/.dotfiles
git add packages/bundle
git commit -m "feat: add package-name"
```

## Key bindings

### AeroSpace

| Key                   | Action                                   |
| --------------------- | ---------------------------------------- |
| `alt + hjkl`          | Focus window                             |
| `alt + shift + hjkl`  | Move window                              |
| `alt + 1-5`           | Switch workspace                         |
| `alt + shift + 1-5`   | Move window to workspace                 |
| `alt + m`             | Messaging workspace (Discord, WhatsApp…) |
| `alt + tab`           | Toggle previous workspace                |
| `alt + shift + tab`   | Move workspace to other monitor          |
| `alt + [` / `alt + ]` | Focus monitor                            |
| `alt + ,`             | Accordion layout                         |
| `alt + /`             | Tiles layout                             |
| `alt + shift + ;`     | Service mode (flatten, join, close all…) |

### Tmux

| Key                 | Action                |
| ------------------- | --------------------- |
| `ctrl + a`          | Prefix                |
| `prefix + \|`       | Split vertically      |
| `prefix + -`        | Split horizontally    |
| `prefix + hjkl`     | Navigate panes        |
| `prefix + g`        | Open lazygit          |
| `prefix + r`        | Reload config         |
| `prefix + ctrl + e` | Search sessions (fzf) |
| `prefix + space`    | Last window           |

### Zsh aliases

| Alias      | Command                                              |
| ---------- | ---------------------------------------------------- |
| `ll`       | `eza -la --icons --git`                              |
| `lt`       | `eza --tree --level=2`                               |
| `lg`       | `lazygit`                                            |
| `n`        | `nvim .`                                             |
| `t`        | `tmux attach \|\| tmux new -s Work`                  |
| `c`        | `opencode`                                           |
| `dotfiles` | `nvim ~/.dotfiles`                                   |
| `dotcd`    | `cd ~/.dotfiles`                                     |
| `rebuild`  | `darwin-rebuild switch --flake ~/.config/nix-config` |
| `cleanup`  | `nix-collect-garbage -d`                             |

## Troubleshooting

**Broken symlinks**

```bash
./install doctor   # diagnose
./install stow     # re-create symlinks
```

**Package installation failures**

```bash
./install retry    # retry failed packages
```

**zsh not loading config**

```bash
# Check the symlink is correct
ls -la ~/.zshrc    # should point to ~/.dotfiles/home/.zshrc

# Reload manually
source ~/.zshrc
```

**AeroSpace not tiling**

```bash
# Reload config from service mode
# Press alt+shift+; then esc
```

**TPM plugins not installed**

```bash
# Inside a tmux session
tmux source ~/.config/tmux/tmux.conf
# Press prefix + I to install plugins
```

## Customization

**Work-specific git config** — create `~/.config/git/work_config` with your
work email and name. It loads automatically for repos under `~/Code/work/`.

**Python tools** — install CLI tools with `uv tool install <package>`.

**New zsh function** — add a file in `~/.config/zsh/fns/`. It loads
automatically on next shell start.

## Acknowledgments

- [GNU Stow](https://www.gnu.org/software/stow/) for symlink management
- [Homebrew](https://brew.sh/) for package management
- [Dillon Mulroy](https://github.com/dmmulroy/.dotfiles) for script inspiration
- [Christopher2K](https://github.com/Christopher2K/nix-config) for AeroSpace config inspiration
- [Omarchy](https://github.com/basecamp/omarchy) for keybinding conventions
