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

## setup and install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN cp -R /root/.oh-my-zsh /home/$USERNAME
RUN cp /root/.zshrc /home/$USERNAME
RUN sed -i -e "s/\/root\/.oh-my-zsh/\/home\/$USERNAME\/.oh-my-zsh/g" /home/$USERNAME/.zshrc
RUN chown -R $USER_UID:$USER_GID /home/$USERNAME/.oh-my-zsh /home/$USERNAME/.zshrc
