FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

LABEL Name="nvim-dev-container" \
      Version="1.0"

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    build-essential \
    python3 \
    python3-pip \
    lua5.3 \
    lua5.3-dev \
    luarocks

RUN luarocks install luacheck

USER vscode
