#!/bin/bash
podman start capsule-$1
podman exec -it --user=$(pass capsule/username) capsule-$1 $2
