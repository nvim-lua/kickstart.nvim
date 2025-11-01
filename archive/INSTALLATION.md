# Complete Installation Guide - Neovim Profile Setup

This guide documents all the tools and setup steps needed to replicate this VS Code-like Neovim configuration on a new computer.

## 📋 Prerequisites

### Required Software
- **macOS** (this guide is for macOS, adapt for Linux/Windows)
- **Homebrew** - Package manager for macOS
- **Neovim v0.10+** - Text editor
- **Git** - Version control

## 🛠️ Installation Steps

### 1. Install Homebrew (if not already installed)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Neovim
```bash
brew install neovim
```

Verify installation:
```bash
nvim --version
# Should show v0.10.0 or higher
```

### 3. Install Node.js via fnm (Fast Node Manager)

#### Why fnm?
- Fast and simple Node.js version manager
- Written in Rust (very fast)
- Better than nvm for switching Node.js versions
- Required for GitHub Copilot and some LSP servers

#### Install fnm
```bash
brew install fnm
```

#### Configure fnm in your shell
Add to `~/.zshrc`:
```bash
# fnm (Fast Node Manager) - for managing Node.js versions
eval "$(fnm env --use-on-cd)"
```

Reload your shell:
```bash
source ~/.zshrc
```

#### Install Node.js LTS
```bash
# Install latest LTS version
fnm install --lts

# Set it as default
fnm default lts-latest

# Verify installation
node --version
# Should show v24.x.x or similar

npm --version
# Should show 11.x.x or similar
```

#### fnm Directory Structure
fnm stores Node.js versions here:
- **Versions**: `~/.local/share/fnm/node-versions/`
- **Default alias**: `~/.local/share/fnm/aliases/default/bin/`

The default alias automatically points to your default Node.js version, so you don't need to update paths when upgrading Node.js.

### 4. Install Bun (Fast JavaScript Runtime)

#### Why Bun?
- Faster than Node.js for development
- Great for running Svelte/TypeScript projects
- Built-in bundler and test runner
- Compatible with Node.js packages

#### Install Bun
```bash
curl -fsSL https://bun.sh/install | bash
```

This installs Bun to `~/.bun/bin/bun`

#### Configure Bun in your shell
Add to `~/.zshrc` (should be added automatically, but verify):
```bash
# Bun - Fast JavaScript runtime
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
```

Reload your shell:
```bash
source ~/.zshrc
```

Verify installation:
```bash
bun --version
# Should show 1.3.x or similar
```

### 5. Clone Kickstart.nvim Configuration

#### Backup existing config (if you have one)
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
```

#### Clone Kickstart.nvim
```bash
git clone https://github.com/nvim-lua/kickstart.nvim.git ~/.config/nvim
```

### 6. Apply Custom Profile Configuration

You need to copy these custom files to your new machine:

#### Required Custom Files
```
~/.config/nvim/
├── init.lua (modified from kickstart)
└── lua/custom/plugins/
    ├── init.lua         # Common plugins (Copilot, Neo-tree)
    ├── flutter.lua      # Flutter/Dart profile
    ├── python.lua       # Python profile
    └── svelte.lua       # Svelte/Web profile
```

#### Copy from this repository
If you've pushed your config to GitHub:
```bash
cd ~/.config/nvim
git remote set-url origin YOUR_FORK_URL
git pull
```

Or manually copy the `lua/custom/` directory from your current setup.

### 7. Configure Node.js Path in Neovim

This is **critical** for GitHub Copilot to work!

The `init.lua` file should have this configuration (around lines 96-110):

```lua
-- ========================================================================
-- NODE.JS PATH CONFIGURATION (for GitHub Copilot and LSP servers)
-- ========================================================================
-- GitHub Copilot and some LSP servers require Node.js to be in PATH.
-- fnm doesn't add Node.js to Neovim's PATH automatically, so we do it here.
-- Using fnm aliases ensures this works even when Node.js version changes.
-- ========================================================================

-- Add fnm Node.js to PATH for Copilot and other Node.js-dependent plugins
local fnm_default_path = vim.fn.expand '~/.local/share/fnm/aliases/default/bin'
local fnm_multishells_path = vim.fn.expand '~/.local/share/fnm/node-versions/*/installation/bin'

if vim.fn.isdirectory(fnm_default_path) == 1 then
  vim.env.PATH = fnm_default_path .. ':' .. vim.env.PATH
elseif vim.fn.glob(fnm_multishells_path) ~= '' then
  local node_path = vim.fn.glob(fnm_multishells_path)
  vim.env.PATH = node_path .. ':' .. vim.env.PATH
end
```

This ensures Neovim can find Node.js even when it's not in the shell PATH.

### 8. First Launch - Install Plugins

#### Open Neovim
```bash
nvim
```

On first launch:
1. **lazy.nvim** will automatically install all plugins
2. Wait for plugins to finish installing (watch the bottom of the screen)
3. You may see some errors - this is normal on first launch

#### Manually sync plugins (if needed)
```vim
:Lazy sync
```

Wait for completion, then restart Neovim:
```vim
:qa
nvim
```

### 9. Install LSP Servers and Tools via Mason

#### Open Mason
```vim
nvim
:Mason
```

#### Required Tools
These should auto-install via `mason-tool-installer`, but verify:

**Common:**
- `lua-language-server` (lua_ls)
- `stylua`

**Flutter:**
- `dart-language-server` (dartls)

**Python:**
- `pyright`
- `ruff`

**Svelte/Web:**
- `svelte-language-server`
- `typescript-language-server` (ts_ls)
- `tailwindcss-language-server`
- `prettier`

#### Manual Installation (if needed)
In Mason, navigate to a tool and press:
- `i` - Install
- `U` - Update
- `X` - Uninstall
- `g?` - Help

### 10. Setup GitHub Copilot

#### Authenticate Copilot
```vim
nvim
:Copilot setup
```

Follow the prompts:
1. It will give you a code
2. Open the URL in your browser
3. Enter the code
4. Authorize GitHub Copilot

#### Verify Copilot works
```vim
:Copilot status
```

Should show: "Copilot: Ready"

### 11. Install Treesitter Parsers

Parsers should auto-install when you open files, but you can manually install:

```vim
:TSInstall dart python svelte typescript tsx javascript css html json lua vim vimdoc
```

Verify:
```vim
:TSInstallInfo
```

## 🔧 Configuration Summary

### Shell Configuration (~/.zshrc)

Your `~/.zshrc` should have these additions:

```bash
# fnm (Fast Node Manager) - for managing Node.js versions
eval "$(fnm env --use-on-cd)"

# Bun - Fast JavaScript runtime
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
```

### Directory Structure After Installation

```
~/.config/nvim/
├── init.lua                    # Main Kickstart config (modified with Node.js PATH)
├── lazy-lock.json              # Plugin versions (auto-generated)
├── LICENSE.md
├── README.md
├── SETUP-GUIDE.md              # Profile setup guide
├── INSTALLATION.md             # This file
├── doc/
│   └── kickstart.txt
└── lua/
    ├── custom/
    │   └── plugins/
    │       ├── init.lua        # Common plugins (Copilot, Neo-tree)
    │       ├── flutter.lua     # Flutter profile
    │       ├── python.lua      # Python profile
    │       └── svelte.lua      # Svelte profile
    └── kickstart/
        └── plugins/
            ├── autopairs.lua
            ├── debug.lua
            ├── gitsigns.lua
            ├── indent_line.lua
            ├── lint.lua
            └── neo-tree.lua

~/.local/share/fnm/
├── aliases/
│   └── default/                # Default Node.js version
│       └── bin/
│           ├── node
│           └── npm
└── node-versions/
    └── v24.11.0/               # Actual Node.js installation

~/.bun/
└── bin/
    └── bun                     # Bun executable

~/.local/share/nvim/
├── lazy/                       # lazy.nvim plugin installations
└── mason/                      # Mason LSP/tool installations
```

## 🧪 Verification Checklist

After installation, verify everything works:

### Check Node.js Setup
```bash
# Should all work:
which node
node --version
which npm
npm --version
which fnm
fnm list
```

### Check Bun Setup
```bash
which bun
bun --version
```

### Check Neovim
```bash
nvim --version
# Should be v0.10.0+
```

### Test in Neovim
```vim
# Open Neovim
nvim

# Check Node.js is in PATH
:echo $PATH
# Should include: /Users/YOUR_USERNAME/.local/share/fnm/aliases/default/bin

# Check Copilot
:Copilot status
# Should show: Ready

# Check plugins
:Lazy
# All plugins should be loaded or available

# Check Mason
:Mason
# All tools should be installed

# Check LSP
:checkhealth lsp
# Should show no errors
```

## 🔄 Updating Tools

### Update Node.js
```bash
# Install new LTS version
fnm install --lts

# Set as default
fnm default lts-latest

# Old versions are kept, you can switch back:
fnm use 22  # if you need an older version
```

The fnm alias system means Neovim automatically uses the new version without config changes!

### Update Bun
```bash
bun upgrade
```

### Update Neovim Plugins
```vim
:Lazy update
```

### Update Mason Tools
```vim
:Mason
# Press 'U' to update all tools
```

### Update Neovim
```bash
brew upgrade neovim
```

## 🐛 Troubleshooting

### Copilot says "Node.js not found"
1. Check Node.js is installed: `which node`
2. Check fnm is in PATH: `which fnm`
3. Verify init.lua has Node.js PATH configuration (see step 7)
4. Restart Neovim completely

### LSP not loading
```vim
:LspInfo          # Check if attached
:checkhealth lsp  # Check for issues
:Mason            # Verify tool is installed
```

### Plugins not loading
```vim
:Lazy check
:Lazy clean
:Lazy sync
```

### Format-on-save not working
```vim
:ConformInfo      # Check formatter config
:Mason            # Verify formatter installed
```

### Treesitter syntax highlighting broken
```vim
:TSUpdate         # Update all parsers
:checkhealth nvim-treesitter
```

## 🚀 Platform-Specific Notes

### Linux
- Use your package manager instead of Homebrew
- fnm install: `curl -fsSL https://fnm.vercel.app/install | bash`
- Bun works the same way
- Shell config goes in `~/.bashrc` or `~/.zshrc`

### Windows (WSL)
- Use WSL2 with Ubuntu/Debian
- Follow Linux instructions above
- Make sure Neovim is installed in WSL, not Windows

### Windows (Native)
- Use Scoop or Chocolatey instead of Homebrew
- fnm Windows install: `winget install Schniz.fnm`
- Bun: `powershell -c "irm bun.sh/install.ps1 | iex"`
- Config goes in `~\AppData\Local\nvim\`

## 📚 Additional Resources

- **Kickstart.nvim**: https://github.com/nvim-lua/kickstart.nvim
- **fnm**: https://github.com/Schniz/fnm
- **Bun**: https://bun.sh
- **Mason**: https://github.com/williamboman/mason.nvim
- **lazy.nvim**: https://github.com/folke/lazy.nvim
- **Neovim**: https://neovim.io

## 📝 Quick Setup Script

For experienced users, here's a one-liner (review before running!):

```bash
# Install Homebrew (if needed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install all tools
brew install neovim fnm && \
fnm install --lts && \
fnm default lts-latest && \
curl -fsSL https://bun.sh/install | bash

# Add to ~/.zshrc
echo 'eval "$(fnm env --use-on-cd)"' >> ~/.zshrc
echo 'export BUN_INSTALL="$HOME/.bun"' >> ~/.zshrc
echo 'export PATH="$BUN_INSTALL/bin:$PATH"' >> ~/.zshrc

# Clone Kickstart
git clone https://github.com/nvim-lua/kickstart.nvim.git ~/.config/nvim

# Copy your custom plugins
# (You need to do this manually from your backup/repo)

# Launch Neovim
source ~/.zshrc
nvim
```

Then in Neovim:
1. Wait for plugins to install
2. Run `:Copilot setup`
3. Restart Neovim
4. Done! 🎉

---

**Last Updated**: October 29, 2025
**Neovim Version**: v0.11.4
**Node.js Version**: v24.11.0 LTS
**Bun Version**: 1.3.1
