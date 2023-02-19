FROM anatolelucet/neovim:nightly

WORKDIR /root/.config/nvim

# Install dependencies
RUN apk add --update \
    bash \
    curl \
    wget \
    gzip \
    unzip \
    git \
    npm \
    alpine-sdk \
    openssh-client \
    python3 \
    cargo \
    ripgrep \
    fd

# Copy files
RUN mkdir -p /root/.config/nvim
COPY . /root/.config/nvim

# Install nvim plugins and lsp servers
RUN nvim --headless "+Lazy! install" +"MasonInstall pyright" +qa

