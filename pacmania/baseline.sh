#!/bin/bash
timestamp=$(date +"%Y%m%d%H%M%S")
mv intent/base.txt intent/base.backup.$timestamp
cat intent/*.txt > /tmp/intents.txt
pacman -Qeq > /tmp/prebase.txt
comm -33 <(sort /tmp/prebase.txt) <(sort /tmp/intents.txt) > /tmp/newbase.txt
for l in $(cat /tmp/newbase.txt); do printf "%-35s%s%s\n" "$l" ";" "$(pacman -Qei $l | grep Description | cut -d':' -f2)" >> intent/base.txt; done
