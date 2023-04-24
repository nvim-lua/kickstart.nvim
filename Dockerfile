# This is devbox which means development environment
# this will contain neovim with kickstart.nvim configuration

FROM python:3-slim-buster

# If you need to run from behind the proxy then set the proxy below
#ENV http_proxy 
#ENV https_proxy 
#ENV no_proxy 

# ripgrep is for rg search
# wget is required to pull neovim app image
RUN apt-get update && apt-get install -y git curl lua5.3 golang-go zip unzip ripgrep build-essential wget locales\
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspaces
# Node js and npm are required for neovim
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
   apt-get install -y nodejs 

# Install latest neovim as appimage. debian apt package is having old neovim
RUN mkdir -p /opt/nvim && cd /opt/nvim \
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb && \
    wget -O /opt/nvim/nvim.appimage https://github.com/neovim/neovim/releases/download/stable/nvim.appimage && \
    chmod +x /opt/nvim/nvim.appimage && \
    /opt/nvim/nvim.appimage --appimage-extract && \
    mv squashfs-root/* /opt/nvim && \
    rm -rf squashfs-root 
    
# Add nvim to PATH
ENV PATH=/opt/nvim/usr/bin:$PATH
ENV LANG C.UTF-8 # UTF-8 support
ENV LC_ALL C.UTF-8

RUN pip install pynvim debugpy
# Clone nvim configuration 
RUN git clone --depth 1 https://github.com/nvim-lua/kickstart.nvim ~/.config/nvim 


# Install project specific
# COPY project.requirements.txt prj2.requirements.txt /tmp/
# RUN pip install -r /tmp/project.requirements.txt \
#     && pip install -r /tmp/prj2.requirements.txt


# ENTRYPOINT ["bin/bash"]

#  --------------- README ------------------------------
# To build it use below command
# docker build -t devbox -f Dockerfile .

# To run it ,use below command
# docker run -td --name vimbox -v $(pwd):/workspaces devbox
# You should run this container from where your source code folder so that your source code will be available inside container

# To execute use the below command
# docker exec -it vimbox /bin/bash

# Once running inside the container
# open folders - nvim /workspaces
# Then wait for all the packages to be installed
# Then install python related packages using
# :MasonInstall pyright pylint black

# debugpy is installed outside so that it can be used.
# Since this is a docker container. You need not to use virtualenv

