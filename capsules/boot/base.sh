#!/bin/bash
FILE="/files/.bootstrap/DONE"

if [ ! -f "$FILE" ]; then
    echo "$CAPSULE_USERNAME   ALL=(ALL:ALL) ALL" >> /etc/sudoers
    echo "$CAPSULE_PASSWORD" | passwd --stdin $CAPSULE_USERNAME
    apt-get update && apt-get install -y --no-install-recommends \
	    locales
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen
    touch "$FILE"
fi
