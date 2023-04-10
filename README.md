# Python Devbox with kickstart.nvim 

### Python Devbox

Prepare your python development environment using neovim with kickstarter.nvim config
This will have all the plugins in kickstart.nvim installed in it. I have added python debug support and neotree as extra

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
