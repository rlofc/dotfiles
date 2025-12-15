FROM debian:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    curl \
    alsa-utils \
    pulseaudio \
    tmux \
    vim \
    bash

RUN apt-get install --reinstall -y ca-certificates
