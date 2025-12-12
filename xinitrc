[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
setxkbmap -option grp:switch,grp:alt_shift_toggle,grp_led:scroll us,il
xmodmap ~/.xmodmap
bash ~/bin/status.sh &
source ~/.xprofile
picom &
feh --bg-fill ~/wall3.jpg
exec dwm
