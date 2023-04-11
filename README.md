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
This repo is forked from Kickstarter.nvim 
For nvim configuration refer : https://github.com/nvim-lua/kickstart.nvim

## Debuypy inside venv problem is resolved
The reason why this Pydevbox is created to solve the problem of installing debugpy inside virtual env.
I tried other NEOVIM distro but always stuck at the point where i have to use debugpy.
But thankfully with the kickstarter.nvim 
inside container doesn't need debugpy to be installed inside venv

## Screenshots
<img width="914" alt="image" src="https://user-images.githubusercontent.com/21053120/231184071-a42a1585-1a48-4795-885b-d30e85c4407c.png">
<img width="632" alt="image" src="https://user-images.githubusercontent.com/21053120/231185219-24d9c6e3-2dfc-4fe6-93e8-138a979723be.png">


## Few VSCode bindings are done
```
Debugger key binding are like vscode`
Ctrl+b will toggle neotree(which is file explorer)
Ctrl+j will toggle terminal (using toggleterm)
```
