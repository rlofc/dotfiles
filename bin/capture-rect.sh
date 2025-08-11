#!/bin/bash
geom=$(./xrectsel)
res=$(echo $geom | cut -f1 -d'+')
offsetx=$(echo $geom | cut -f2 -d'+')
offsety=$(echo $geom | cut -f3 -d'+')
echo $res
echo $offsetx
echo $offsety
filename="capture-$(date +'%Y-%m-%d-%H-%M').mp4"
sleep 3
#unclutter --start-hidden  --ignore-buttons 4,5 --idle 10 --jitter 10000000 &
ffmpeg -draw_mouse 0 -video_size $res -framerate 25 -f x11grab -i :0.0+$offsetx,$offsety $filename
#kill %1
