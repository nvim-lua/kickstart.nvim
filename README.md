# Why this PyDevBox is developed
I love to use vscode. Lately I love nvim editor as well.
The initial configuration was a steep learning curve. Thanks to kickstart.nvim which helped me at last.
Now I have put Neovim and my configuration in dockerfile so that this environment can be used as devbox.

# Python Devbox with kickstart.nvim 

### Python Devbox

Prepare your python development environment in container. This devbox contains neovim with kickstarter.nvim config
I have added python debug support and neotree as extra

```
# Build your devbox image
docker build -t devbox -f devbox.Dockerfile .

# To run the container in background
docker run -td --name mydevbox -v $(pwd):/workspaces devbox
# -v $(pwd) is used to create volume inside container . IF you run from the folder where your source code is available then your container will have source code in it. You can use this as development box

# To enter into devbox 
docker exec -it mydevbox /bin/bash

# You can do debug using standard keys used in vscode
F5 - to start debug
F9 - to toggle debug breakpointer
F10 - step over
F11 - step into
shift + F11 - step out

```
### To install locally
```
git clone https://github.com/SamPosh/PyDevbox ~/.config/nvim --depth 1 && nvim
```

### To uninstall 
```
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim

```

This repo is forked from Kickstarter.nvim 
For nvim configuration refer : https://github.com/nvim-lua/kickstart.nvim

## Features
1) It is inside container. So this devbox can act like devcontainer (vscode)
2) Code block can be collapsed/expanded like vscode
3) Debugging can be done for python/Pytest. Also added sample configuration for profiler as well.


## Debuypy inside venv problem is resolved
The reason why this Pydevbox is created to solve the problem of installing debugpy inside virtual env.
I tried other NEOVIM distro but always stuck at the point where i have to use debugpy.
But thankfully with the kickstarter.nvim 
inside container doesn't need debugpy to be installed inside venv

## Screenshots
#### screen with terminal and filetree
<img width="914" alt="image" src="https://user-images.githubusercontent.com/21053120/231184071-a42a1585-1a48-4795-885b-d30e85c4407c.png">

#### start debug
<img width="632" alt="image" src="https://user-images.githubusercontent.com/21053120/231185219-24d9c6e3-2dfc-4fe6-93e8-138a979723be.png">

#### Debug
<img width="893" alt="image" src="https://user-images.githubusercontent.com/21053120/231185848-1aec925d-bf80-4548-8d70-d3d1760e3563.png">

##### Notes:
```
I am using Termius terminal emulator.
Using Fira code font 
```

## Few VSCode bindings are done
```
Debugger key binding are like vscode`
Ctrl+b will toggle neotree(which is file explorer)
Ctrl+j will toggle terminal (using toggleterm)
```

### Python debug configuration
Debug configuration is available in this file
https://github.com/SamPosh/PyDevbox/blob/master/lua/kickstart/plugins/dap/handler/python.lua
If you want to add additional configuration then you can add it here


### Minor problem need to be resolved yet
Paste into nvim works fine. But copy from neovim to outside doesn't work. I could not figure out any solution till now.
So for copying contents i am using alternate solution like cat it and copy it from terminal. This is a minor problem

