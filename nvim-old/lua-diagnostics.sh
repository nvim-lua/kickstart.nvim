#!/bin/bash

# Directories and file names
nvim_lua_dir="$HOME/.config/nvim/lua"
module1="tmux_split_even_horizontal.lua"
module2="toggle_rel_abs_numbers.lua"

# Function to check if a file exists
check_file() {
    if [[ -f "$1" ]]; then
        echo "File exists: $1"
    else
        echo "File NOT found: $1"
    fi
}

echo "Checking Lua modules..."

# Check Lua modules
check_file "$nvim_lua_dir/$module1"
check_file "$nvim_lua_dir/$module2"

# Check LUA_PATH
echo "Checking LUA_PATH..."
echo "LUA_PATH=$LUA_PATH"

# Check Lua module loading
echo "Attempting to manually load Lua modules..."
lua -e "require('tmux_split_even_horizontal'); print('Module tmux_split_even_horizontal loaded successfully')"
lua -e "require('toggle_rel_abs_numbers'); print('Module toggle_rel_abs_numbers loaded successfully')"

echo "Diagnostic checks complete."

