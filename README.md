## ⚙️  My Neovim Configuration

This is my personal neovim configuration and it's unlikely to be perfect
for your use case.

What is in it?

* *Kickstart*: based configuration
* *Neovimacs*: modeless editing support, with common Emacs bindings in insert mode
* *Esc*: to toggle between insert (emacs bindings) and normal (neovim mode)
* *Tabs*: Prev (F1), Next (F2), New (F3), and Close (F4) to jump around
* *Tool Tabs*: Terminal (F5)
* *Movement*: Arrows and Tabs (and, yes, I know)
* *Batteries*: Python LSP, completion, treesitter

## 📦 Installation

#### Prep

Suggested:

```bash
sudo apt install -y gcc python3-pip python3-venv git make unzip ripgrep gzip wget curl fd-find npm
sudo npm install -g tree-sitter-cli
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
:CheckHealth
:lua print(vim.inspect(vim.opt.XXXX))
:set option?
```

Beyond [which-key](https://github.com/folke/which-key.nvim), you can use the following
nvim commands to help you track down key bindings and resolve conflicts:

```
:verbose imap <C-n>   -- for insert mode
:verbose nmap <C-n>   -- for normal mode
:nmap <localleader>   -- to see leader commands
:WhichKey             -- see above
```


### References

Kickstart: [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
Kickstart Video: [Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

