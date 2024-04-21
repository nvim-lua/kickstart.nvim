#!/bin/bash

# Setup virtual environment for dap-py
python3 -m venv .venv
.venv/bin/pip install debugpy

# Install dependencies
PKGS=("cppcheck" "clang" "cmake" "npm")

# Get distro
distro=$(cat /etc/os-release | grep PRETTY_NAME= | awk '{print $1}' | cut -d \" -f 2)

# Prompt user to install dependencies
for pkg in ${PKGS[@]}; do
    read -p "Do you want to install $pkg? (y/n): " response
    if [ "$response" == "y" ]; then
	case $distro in
	    "Ubuntu")
		sudo apt-get install $pkg
		;;
	    "Arch")
		sudo pacman -S $pkg
		;;
	    *)
		echo "Unsupported distro"
		;;
	esac
    fi
done

# Get dat google auto formatter style
~/.local/share/nvim/mason/bin/clang-format --style GNU --dump-config > ~/.config/nvim/.clang-format
