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

### Problems need to be resolved yet
copy/paste from the container to outside is not working. I am still trying to figure out a solution
