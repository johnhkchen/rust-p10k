FROM mcr.microsoft.com/devcontainers/rust:latest
WORKDIR /home/

COPY . .

ENV PATH="/root/.cargo/bin:$PATH"


## Install rustup and common components
RUN rustup component add rustfmt
RUN rustup component add rustfmt --toolchain nightly
RUN rustup component add clippy 
RUN rustup component add clippy --toolchain nightly

## update and install some things we should probably have
RUN apt-get update
RUN apt-get install -y \
  curl \
  git \
  gnupg2 \
  jq \
  sudo \
  zsh \
  vim \
  build-essential \
  openssl \
  lld \
  clang
  
## Use cargo binstall for quick installation of cargo tools
RUN curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
RUN cargo binstall --no-confirm --no-symlinks cargo-expand cargo-edit cargo-watch cargo-tarpaulin just
