FROM ubuntu:latest

# Install dependencies
RUN apt update && apt upgrade -y 
RUN apt install -y \
    curl \
    wget \
    make \
    g++ \
    gzip \
    unzip \
    git \
    python3 \
    python3-venv \
    cargo \
    ripgrep \
    fd-find

RUN apt remove -y nodejs npm && \
    curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt install -y nodejs

# Installation Settings
# branch can be nightly
ENV BRANCH=stable
ENV LSP_LIST='lua-language-server'
ENV TS_LIST='c cpp go lua python rust tsx typescript help vim'

# Install NeoVim
RUN wget https://github.com/neovim/neovim/releases/download/${BRANCH}/nvim-linux64.tar.gz
RUN tar xzvf nvim-linux64.tar.gz
ENV PATH="/nvim-linux64/bin:${PATH}"

# Copy files
WORKDIR /root/.config/nvim
RUN mkdir -p /root/.config/nvim
COPY . /root/.config/nvim

# Install nvim plugins and lsp servers
RUN nvim --headless "+Lazy! install" +"MasonInstall ${LSP_LIST}" +qa
RUN nvim --headless +"TSUpdateSync ${TS_LIST}" +qa

