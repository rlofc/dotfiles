#!/bin/bash

apt-get update && apt-get install -y --no-install-recommends \
  emacs \
  git \
  just \
  ripgrep \
  gcc \
  g++ \
  make \
  curl \
  sqlite3 \
  libgnutls28-dev \
  libncurses-dev \
  libxml2-dev \
  zlib1g-dev \
  cmake \
  ffmpeg
apt-get install --reinstall -y ca-certificates
fc-cache -f

sudo -u $CAPSULE_USERNAME bash -c '\
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d \
&& ~/.emacs.d/bin/doom install --force \
&& ~/.emacs.d/bin/doom sync
'    

sudo -u $CAPSULE_USERNAME bash -c '\
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
&& /files/home/$CAPSULE_USERNAME/.cargo/bin/rustup install stable \
&& /files/home/$CAPSULE_USERNAME/.cargo/bin/rustup component add rust-analyzer
'
sudo -u $CAPSULE_USERNAME bash -c '\
cargo install --locked typst-cli
'

# HEXROLL3 stuff
apt-get install wayland-client++ libwayland-client0 libasound2-dev libudev-dev pkg-config
apt-get install gcc-mingw-w64-x86-64-win32 zip

echo "$CAPSULE_USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
