#!/bin/bash
CAPSULE_USERNAME="$(pass capsule/username)"
mkdir -p /files/volumes/$2/home/$CAPSULE_USERNAME
mkdir /files/volumes/$2/.bootstrap/
cp boot/$2.sh /files/volumes/$2/.bootstrap/
rm -f /files/volumes/$2/.bootstrap/DONE
podman run -it --gpus all -e DISPLAY=:0 --net=host \
    --userns=keep-id --user=root \
    -v /dev/snd:/dev/snd:rw \
    -v /dev/shm:/dev/shm:rw \
    -v /run/user/1000/pulse:/run/user/host/pulse:rw \
    -v /files/projects/ark/config:/files/home/$CAPSULE_USERNAME/.config:rw \
    -v /files/projects/ark/fonts:/files/home/$CAPSULE_USERNAME/.fonts \
    -v /files/volumes/$2:/files:rw \
    -e PULSE_SERVER=unix:/run/user/host/pulse/native \
    -e BOOTSTRAP="$2.sh" \
    -e CAPSULE_USERNAME="$CAPSULE_USERNAME" \
    -e CAPSULE_PASSWORD="$(pass capsule/password)" \
    $3 $4 \
    $5 $6 \
    --name=capsule-$2 $1
