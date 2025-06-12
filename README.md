## ⚙️ My Neovim Configuration

This is my personal neovim configuration and it's unlikely to be perfect
for your use case.

What is in it?

- _Kickstart_: based configuration
- _Neovimacs_: modeless editing support, with common Emacs bindings in insert mode
- _Esc_: to toggle between insert (emacs bindings) and normal (neovim mode)
- _Tabs_: Prev (F1), Next (F2), New (F3), and Close (F4) to jump around
- _Tool Tabs_: Terminal (F5)
- _Movement_: Arrows and Tabs (and, yes, I know)
- _Batteries_: Python LSP, completion, treesitter

## 📦 Installation

#### Prep

Neovim >= 0.10 or later is required, you may need to get it from the Neovim PPA or similar:

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
```

Suggested Packages:

```bash
sudo apt install -y cargo gcc python3-pip python3-venv git make unzip ripgrep gzip wget curl fd-find npm xclip
sudo npm install -g tree-sitter-cli
```

If you have an old version of NodeJS, pick up a new one:

```bash
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
```

Optional based on use-case:

```bash
sudo apt install -y golang luarocks cargo nodejs clang python3-pynvim
```

#### Cloning

```bash
cd ~/.config
git clone https://github.com/millerjason/neovimrc.git
ln -s neovimrc nvim
```

#### Maint

```
:Lazy         - upgrade packages
:Mason        - build external tools
```

## Life with Neovim

#### Do you have everything and is it working correctly?

Checking overall health and options:

```
:checkhealth
:Telescope vim_options
:lua print(vim.inspect(vim.opt.XXXX))
```

Beyond [which-key](https://github.com/folke/which-key.nvim), you can use the following
nvim commands to help you track down key bindings and resolve conflicts:

```
:verbose imap <C-n>   -- for insert mode
:verbose nmap <C-n>   -- for normal mode
:nmap <localleader>   -- to see leader commands
:WhichKey             -- see above
:lua = <expr>         -- run lua expression
```

Use `nvim -u NONE -U NONE -N -i NONE` to test with w/o config if things go wrong.

#### Recommended Visits

```
:help <module>           -- help for modules
:help telescope.setup()  -- help for the setup section
:Telescope help_tags     -- search help
```

### References

Kickstart: [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
Kickstart Video: [Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)
Docs: [https://neovim.io/doc/user/](Manual)
