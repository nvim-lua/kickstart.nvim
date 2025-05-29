# Disable flow control (Ctrl+S, Ctrl+Q) in the terminal
# This allows Ctrl+S to be used for saving in Neovim
stty -ixon

# Optional: You can also add this line to make Ctrl+S work in programs that use readline
# (like the bash/zsh command line itself)
if [ -t 0 ]; then
  bind -r '\C-s' 2>/dev/null || true
fi
