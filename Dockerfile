# Build neovim separately in the first stage
FROM alpine:latest AS base

RUN apk --no-cache add \
    autoconf \
    automake \
    build-base \
    cmake \
    ninja \
    coreutils \
    curl \
    gettext-tiny-dev \
    git \
    libtool \
    pkgconf \
    unzip

# Build neovim (and use it as an example codebase
RUN git clone https://github.com/neovim/neovim.git

ARG VERSION=master
RUN cd neovim && git checkout ${VERSION} && make CMAKE_BUILD_TYPE=RelWithDebInfo install

# To support kickstart.nvim
RUN apk --no-cache add \
    fd  \
    ctags \
    ripgrep \
    git

# Copy the kickstart.nvim init.lua
COPY ./init.lua /root/.config/nvim/init.lua

WORKDIR /neovim
