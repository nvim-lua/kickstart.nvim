#!/bin/sh
# A script to manage inverse search from both LyTeX and LaTeX files
# Arguments:
# 1: line number to display
#    e.g. "42"
# 2: path to LaTeX source file
#    e.g. "$HOME/test/tex/test.tex"
# 3: operating system name as returned by uname
#    i.e. "Darwin" on macOS and "Linux" on Linux

# echo "${1}\n${2}" > "${HOME}/log.txt"

function inverse_search() {
  # Arguments:
  # 1: path to Neovim server socket
  #    e.g. "/tmp/texsocket" or "/tmp/lytexsocket"
  # 2: line number to display
  #    e.g. "42"
  # 3: path to the file to display
  #    e.g. /Users/ejmastnak/test/tex/test.tex
  # 4: operating system name as returned by uname
  #    i.e. "Darwin" on macOS and "Linux" on Linux
  if [ ${4} = "Darwin" ]  # macOS
  then
    nvr --servername="${1}" +"${2}" "${3}" && open -a Alacritty
  else  # Linux/other
    nvr --servername="${1}" +"${2}" "${3}"
  fi
}

# read first line of /tmp/inverse-search-target.txt into the variable target
read -r target < /tmp/inverse-search-target.txt

if [ ${target} = "TEX" ]  # standard TEX inverse search
then
  inverse_search "/tmp/texsocket" "${1}" "${2}" "${3}"
elif [ ${target} = "LYTEX" ]  # LilyPond LYTEX inverse search
then

  # change extension from ".tex" to ".lytex" using "${2%"tex"}lytex"
  # replace "lilybook-out/" with "" sed using 's/lilybook-out\///'
  lytex_file=$(echo "${2%"tex"}lytex" | sed 's/lilybook-out\///')

  # get line in LYTEX file corresponding to line in TEX file
  lytex_to_tex_script="$HOME/.config/nvim/personal/lilypond-scripts/lytex-to-tex.sh"
  lytex_line=$(sh "${lytex_to_tex_script}" ${1} "${2}" "${lytex_file}")
  inverse_search "/tmp/lytexsocket" "${lytex_line}" "${lytex_file}" "${3}"

  # echo "TEX line: ${1}"
  # echo "LYTEX line: ${lytex_line}"
else
  exit
fi
