#!/bin/bash
pacman -Sy  --noconfirm --overwrite=/usr/lib/* firefox firefox-ublock-origin

echo "$CAPSULE_USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

mv -n /files/.bootstrap/ff $CAPSULE_HOMEDIR/$CAPSULE_USERNAME/ff
mv -n /files/.bootstrap/ffprofile $CAPSULE_HOMEDIR/$CAPSULE_USERNAME/ffprofile
