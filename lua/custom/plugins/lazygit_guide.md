# LazyGit Guide: A Powerful Git Interface for Your Terminal

![LazyGit Banner](https://raw.githubusercontent.com/jesseduffield/lazygit/assets/logo.png)

## What is LazyGit?

LazyGit is a simple terminal UI for git commands, written in Go with the gocui library. It's designed to make Git operations more intuitive and faster through a clean, keyboard-driven interface that allows you to perform complex git operations with just a few keystrokes.

## Benefits of Using LazyGit

1. **Improved Productivity**: Perform common Git operations in seconds
2. **Intuitive Interface**: Easy-to-navigate TUI (Terminal User Interface)
3. **Visual Representation**: See staged/unstaged changes, branches, commits, and stashes at a glance
4. **Keyboard-Driven**: Everything can be done with keyboard shortcuts
5. **Seamless Integration with Neovim**: Use LazyGit directly from your editor

## Installation

### System Installation

For LazyGit to work in Neovim, you need to install it on your system first:

**Debian/Ubuntu-based systems (like Kali Linux)**:

```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz
```

**Using your package manager**:

```bash
# On Arch Linux
sudo pacman -S lazygit

# On macOS with Homebrew
brew install lazygit

# On Windows with Scoop
scoop install lazygit
```

### Neovim Plugin Installation

You've already added the plugin to your Neovim configuration. It's registered in:

- `/home/kali/.config/nvim/lua/custom/plugins/lazygit.lua`
- Updated in `/home/kali/.config/nvim/lua/custom/plugins/init.lua`

## Using LazyGit in Neovim

### Basic Commands

| Command                     | Description                        | Neovim Keymap |
| --------------------------- | ---------------------------------- | ------------- |
| `:LazyGit`                  | Open LazyGit in a floating window  | `<leader>gg`  |
| `:LazyGitConfig`            | Open LazyGit config                | `<leader>gc`  |
| `:LazyGitCurrentFile`       | Open LazyGit with current file     | `<leader>gf`  |
| `:LazyGitFilter`            | Open LazyGit with commit filtering | -             |
| `:LazyGitFilterCurrentFile` | Filter commits for current file    | -             |

### LazyGit Interface Overview

When you open LazyGit, you'll see a split interface with multiple panels:

1. **Status Panel** (top left): Shows git status
2. **Files Panel** (middle left): Shows changed files
3. **Branches Panel** (bottom left): Shows branches
4. **Commits Panel** (right): Shows commit history
5. **Stash Panel** (may appear when needed): Shows stashed changes

### Essential Keyboard Shortcuts

#### Navigation

| Key       | Action                  |
| --------- | ----------------------- |
| `Tab`     | Switch between panels   |
| `h/j/k/l` | Navigate within panels  |
| `?`       | Show help/keybindings   |
| `q`       | Close current view/quit |

#### Working with Files

| Key     | Action                                           |
| ------- | ------------------------------------------------ |
| `Space` | Toggle staged/unstaged for file (in files panel) |
| `a`     | Stage all changes                                |
| `d`     | View diff for file                               |
| `e`     | Edit file                                        |
| `o`     | Open file                                        |
| `c`     | Commit changes                                   |
| `A`     | Amend last commit                                |
| `C`     | Commit changes with editor                       |

#### Working with Branches

| Key     | Action                                    |
| ------- | ----------------------------------------- |
| `n`     | Create new branch                         |
| `Space` | Checkout branch (in branches panel)       |
| `M`     | Merge selected branch into current branch |
| `P`     | Pull from remote                          |
| `p`     | Push to remote                            |
| `F`     | Force push                                |

#### Working with Commits

| Key | Action                |
| --- | --------------------- |
| `s` | Squash down/fixup     |
| `r` | Reword commit message |
| `f` | Fixup commit          |
| `d` | Delete commit         |
| `g` | Reset to commit       |
| `t` | Tag commit            |

#### Stashing

| Key     | Action                        |
| ------- | ----------------------------- |
| `s`     | Create stash (in files panel) |
| `Space` | Apply stash (in stash panel)  |
| `g`     | Pop stash                     |
| `d`     | Drop stash                    |

## Advanced Features

### Custom Commands

LazyGit allows you to define custom commands in your config file. For example:

```yaml
customCommands:
  - key: "C"
    command: "git cz"
    context: "files"
    description: "commit with commitizen"
  - key: "T"
    command: "tig {{.SelectedFile.Name}}"
    context: "files"
    description: "tig selected file"
```

### Bisect Mode

LazyGit supports git bisect to find the commit that introduced a bug:

1. Press `b` to enter bisect mode
2. Mark commits as good/bad using `g`/`b` respectively
3. LazyGit will help you narrow down the problematic commit

### Interactive Rebase

LazyGit makes interactive rebasing visual and intuitive:

1. Navigate to a commit you want to rebase from
2. Press `i` to start an interactive rebase
3. Use the keyboard to reorder/squash/edit commits
4. Press `esc` or `q` to exit the rebase view

## Integrating with Your Workflow

### Working with Remote Repositories

- Use `P` to pull from upstream
- Use `p` to push to origin
- Use `F` to force push (with lease)

### Working with Submodules

- Navigate to the submodule panel
- Use `Enter` to open/interact with a submodule

### Working with Merge Conflicts

When you encounter merge conflicts:

1. The files with conflicts will be highlighted
2. Select the file to see the conflict
3. Press `e` to edit and resolve
4. Stage the resolved files with `Space`
5. Complete the merge with `m`

## Customizing LazyGit

### Configuration File

LazyGit can be configured via `~/.config/lazygit/config.yml`.

Sample configuration:

```yaml
gui:
  theme:
    activeBorderColor:
      - green
      - bold
    inactiveBorderColor:
      - white
    optionsTextColor:
      - blue
  showCommandLog: true
  showRandomTip: true
  showFileTree: true
  showBottomLine: true

git:
  paging:
    colorArg: always
    pager: delta --dark --paging=never
```

## Troubleshooting Common Issues

### LazyGit Is Slow

- Update to the latest version
- Consider disabling file watching: `git config --global core.fsmonitor false`
- Limit the number of commits shown: `git config --global lazygit.commitLimit 100`

### Merge Conflicts Not Resolving

- Make sure your merge tool is properly configured
- Try resolving with a different editor: `git config --global merge.tool vimdiff`

### Visual Issues

- Check your terminal supports true color
- Try a different theme in your configuration
- Ensure your terminal font has the necessary glyphs

## Conclusion

LazyGit is an incredibly powerful tool that can significantly improve your Git workflow. By integrating it with Neovim, you've created a seamless development environment where complex Git operations are just a few keystrokes away.

Start using LazyGit today to experience a faster, more intuitive way to work with Git!

## Additional Resources

- [LazyGit GitHub Repository](https://github.com/jesseduffield/lazygit)
- [LazyGit Documentation](https://github.com/jesseduffield/lazygit/tree/master/docs)
- [Video Tutorials](https://www.youtube.com/results?search_query=lazygit+tutorial)
