FROM archlinux:latest

RUN  pacman -Sy --noconfirm && pacman -S --noconfirm --overwrite=/usr/lib/* sudo bash alsa-lib alsa-utils pulseaudio curl tmux vim

ENV HOME="/files/home/$CAPSULE_USERNAME"

ENTRYPOINT ["/bin/sh","-c","/files/.bootstrap/$BOOTSTRAP && sudo -u $CAPSULE_USERNAME /bin/bash"]
