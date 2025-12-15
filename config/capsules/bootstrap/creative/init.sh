#!/bin/bash
echo "$CAPSULE_USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

apt-get update && apt-get install -y --no-install-recommends \
  fonts-inter \
  alsa-utils \
  pulseaudio \
  gimp \
  inkscape \
  krita \
  mypaint \
  audacity

touch "$FILE"
