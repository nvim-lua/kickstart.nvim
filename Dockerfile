FROM ubuntu:latest

# Install dependencies
RUN apt update && apt install -y \
    curl \
    wget \
    gzip \
    unzip \
    git \
    npm \
    python3 \
    cargo \
    ripgrep \
    fd-find

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

