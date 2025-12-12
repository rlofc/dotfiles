#!/bin/bash
podman start capsule-$1
podman exec -it --user=root capsule-$1 $2
