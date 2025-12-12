#!/bin/bash
FILE="/files/.bootstrap/DONE"

if [ ! -f "$FILE" ]; then
    pacman -S  --noconfirm --overwrite=/usr/lib/* firefox firefox-ublock-origin

    echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
    echo "$CAPSULE_PASSWORD" | passwd --stdin $CAPSULE_USERNAME
    gpasswd -a $CAPSULE_USERNAME wheel
    touch "$FILE"
fi
