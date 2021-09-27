source "$HOME/.antigen/antigen.zsh"

antigen use oh-my-zsh
antigen bundle arialdomartini/oh-my-git
antigen theme arialdomartini/oh-my-git-themes oppa-lana-style

antigen apply

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH=$PATH:$(go env GOPATH)/bin
alias config='/usr/bin/git --git-dir=/Users/rporter/.cfg/ --work-tree=/Users/rporter'
