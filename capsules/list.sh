#!/bin/bash
podman container list -a --format '{{printf "%-40s %-40s %-40s" .Names  .Image .Status}}' | grep capsule
