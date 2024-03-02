#!/bin/sh
# Used for inverse search from a PDF in Zathura 
# to the corresponding *.tex in Neovim on Linux.
# xdotool is used to return focus to the Vim window.
#
# SYNOPSIS
#   inverse <tex_file> <line_num> <window_id>
# ARGUMENT
#    <tex_file>
#     Path to the LaTeX file to open in Neovim
#    
#    <line_num>
#     Line number to move the cursor to in the opened LaTeX file
#    
#    <window_id>
#     Numerical ID of the window in which Vim is running
#     as returned by `xdotool getactivewindow`.
#     E.g. 10485762
nvr --remote-silent --servername=/tmp/texsocket +"${2}" "${1}"
xdotool windowfocus ${3}
