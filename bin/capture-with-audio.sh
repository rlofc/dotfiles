#!/bin/bash
geom=$(xwininfo | grep geometry | cut -f4 -d' ')
res=$(echo $geom | cut -f1 -d'+')
offsetx=$(echo $geom | cut -f2 -d'+')
offsety=$(echo $geom | cut -f3 -d'+')
echo $res
echo $offsetx
echo $offsety
filename="capture-$(date +'%Y-%m-%d-%H-%M').mp4"
sleep 3
ffmpeg -video_size $res -framerate 25 -f x11grab -i :0.0+$offsetx,$offsety -f jack -i ffmpeg $filename
