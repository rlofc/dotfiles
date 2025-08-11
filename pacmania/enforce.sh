#!/bin/bash
pacman -Qeq > /tmp/installed.txt
rm -f /tmp/intent.txt
cat ./intent/*.txt | cut -d' ' -f1 >> /tmp/intent.txt
to_remove=$(comm -23 <(sort /tmp/installed.txt) <(sort /tmp/intent.txt))
if [ ! -z "$to_remove" ]; then
	if [[ $(echo "$to_remove" | wc -l) -ge 40 ]]; then
		echo "SAFETY ERROR: removal list too big!"
		exit 1
	else
		sudo pacman -Ru $to_remove
	fi
else
	echo "No packages marked for removal"
fi
pacman -Qq > /tmp/installed.txt
to_install=$(comm -13 <(sort /tmp/installed.txt) <(sort /tmp/intent.txt | uniq))
if [ ! -z "$to_install" ]; then
	sudo pacman -S $to_install
else
	echo "No packages marked for installation"
fi
to_clean=$(pacman -Qtdq)
if [ ! -z "$to_clean" ]; then
	sudo pacman -Rns $to_clean
else
	echo "No orphan packages to clean"
fi
