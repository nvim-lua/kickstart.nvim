if [ ! -f ~/.fzf.zsh ]; then 
    cat<<EOF 
    FZF Not installed!

    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
EOF
else
    source ~/.fzf.zsh
fi

alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias vimconfig="GIT_DIR=$HOME/.cfg GIT_WORK_TREE=$HOME nvim"
alias asdfg="setxkbmap -option ctrl:nocaps dvorak"
alias aoeu="setxkbmap -option ctrl:nocaps us"

setopt no_share_history
unsetopt share_history

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export ANDROID_SDK_ROOT=$HOME/Android/Sdk
PATH=$PATH:$ANDROID_SDK_ROOT/emulator
PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH

export EDITOR="nvim"

if [ ! -f $HOME/antigen/antigen.zsh ]; then
    cat <<EOF
    Antigen not installed!

    git clone https://github.com/zsh-users/antigen.git ~/antigen
EOF
else
   source "$HOME/antigen/antigen.zsh"

   antigen bundle zsh-users/zsh-autosuggestions
   antigen use oh-my-zsh
   antigen bundle arialdomartini/oh-my-git
   antigen theme arialdomartini/oh-my-git-themes oppa-lana-style
   antigen apply
fi

. $HOME/.asdf/asdf.sh

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
