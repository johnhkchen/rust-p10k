FROM rust:latest

WORKDIR /home/

COPY . .

ENV PATH="/root/.cargo/bin:$PATH"

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

## Install rustup and common components
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y 
RUN rustup install nightly
RUN rustup component add rustfmt
RUN rustup component add rustfmt --toolchain nightly
RUN rustup component add clippy 
RUN rustup component add clippy --toolchain nightly

RUN cargo install cargo-expand
RUN cargo install cargo-edit
RUN cargo install cargo-watch
RUN cargo install just
