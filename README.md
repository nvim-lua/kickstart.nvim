Setting up Dev Environment

# Operating System

## Installing Fonts
```bash
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
```

## Install command line stuff
fd
ripgrep
tmux

# Shell

## ZSH (standard with mac)

https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH

| OS | PATH |
| :- | :--- |
| Linux | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%userprofile%\AppData\Local\nvim\` |
| Windows (powershell)| `$env:USERPROFILE\AppData\Local\nvim\` |

## Oh-My-Zsh
The plugin management for ZSH
https://github.com/ohmyzsh/ohmyzsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Powerlevel10k
https://github.com/romkatv/powerlevel10k#oh-my-zsh

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
In `~/.zshrc`
```
ZSH_THEME="powerlevel10k/powerlevel10k"
```

# Terminal Management

Install tmux
https://github.com/tmux/tmux/wiki

Install TPM
https://github.com/tmux-plugins/tpm

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

At bottom of `~/.tmux.conf`
```
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'github_username/plugin_name#branch'
# set -g @plugin 'git@github.com:user/plugin'
# set -g @plugin 'git@bitbucket.com:user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

## Plugins
The installation of these should be covered by the included .tmux.conf
To install plugins, use prefix + I (capital )
https://draculatheme.com/tmux

# Tmux Default 
Once ZSH is setup, then add this to the bottom of ~/.zshrc to open tmux with new terminals.
```bash
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s main
fi
```

# Editor

Install neovim

## Plugin Management

# Important Config Files
~/.zshrc
~/.tmux.conf
~/.config/nvim

# Useful Videos
https://www.youtube.com/watch?v=H70lULWJeig

# Java Debugging Setup
Following steps from here
https://sookocheff.com/post/vim/neovim-java-ide/

Clone this repo
https://github.com/microsoft/java-debug

cd into the repo
`./mvnw clean install`

