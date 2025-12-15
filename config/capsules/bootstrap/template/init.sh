#!/bin/bash
echo "$CAPSULE_USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
apt-get update && apt-get install -y --no-install-recommends \
    locales
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
touch "$FILE"
